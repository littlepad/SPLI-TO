package net.littlepad.splito.controllers
{
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import net.littlepad.splito.data.OutputSettingData;
	import net.littlepad.splito.events.MainModelEvent;
	import net.littlepad.splito.events.SplitPageViewEvent;
	import net.littlepad.splito.models.MainModel;
	import net.littlepad.splito.views.dialogs.ProgressDialog;

	public class MainController
	{
		private var _model:MainModel;
		private var _view:Splito;
		private var _progressDialog:ProgressDialog;
		
		public function MainController(model:MainModel, view:Splito)
		{
			_model = model;
			_view = view;
			addEvents();
		}
		
		private function addEvents():void
		{
			// 画像配置時のスライダー設定
			_view.splitPage.addEventListener(SplitPageViewEvent.DISPLAY_COMPLETE, function():void{
				_view.slider.value = uint(_view.splitPage.minScale*100);
				if(_view.slider.value == 100){
					_view.slider.enabled = false;
				} else {
					_view.slider.enabled = true;
				}
			});
			
			// 保存ボタンの監視
			_view.saveButton.addEventListener(MouseEvent.CLICK, saveButtonClickHandler);
			_view.slider.addEventListener(FlexEvent.VALUE_COMMIT, sliderValueCommitHandler);
		}
		
		private function sliderValueCommitHandler(event:FlexEvent):void
		{
			_view.splitPage.resizeImage(event.target.value / 100);
		}
		
		/**
		 * ボタンのクリックハンドラ
		 * @param Event MouseEvent
		 */
		private function saveButtonClickHandler(event:MouseEvent):void
		{
			if(_view.splitPageController.model.jpegUrl){
				popUpProgressDialog();
				
				var jpegUrl:String = _view.splitPageController.model.jpegUrl;
				var outputSettingData:OutputSettingData = new OutputSettingData(_view.splitPage.scale, _view.splitPage.getLeftPageRect(), _view.splitPage.getRightPageRect());
				_model.addEventListener(MainModelEvent.LOAD_ERROR, loadErrorHandler);
				_model.addEventListener(MainModelEvent.OUTPUT_PROGRESS, outputProgressHandler);
				_model.addEventListener(MainModelEvent.OUTPUT_COMPLETE, outputCompleteHandler);
				_model.loadImage(jpegUrl, outputSettingData);
			}
		}
		
		private function loadErrorHandler(event:MainModelEvent):void
		{
			_model.removeEventListener(MainModelEvent.LOAD_ERROR, loadErrorHandler);
			_model.removeEventListener(MainModelEvent.OUTPUT_PROGRESS, outputProgressHandler);
			_model.removeEventListener(MainModelEvent.OUTPUT_COMPLETE, outputCompleteHandler);
			PopUpManager.removePopUp(_progressDialog);
			Alert.show("画像が読み込めませんでした", "画像読み込みエラー");
		}
		
		private function outputProgressHandler(event:MainModelEvent):void
		{
			_progressDialog.progressBar.width = (_progressDialog.progressBarBase.width - 2) * event.parcent/100;
		}
		
		private function outputCompleteHandler(event:MainModelEvent):void
		{
			_model.removeEventListener(MainModelEvent.OUTPUT_PROGRESS, outputProgressHandler);
			_model.removeEventListener(MainModelEvent.OUTPUT_COMPLETE, outputCompleteHandler);
			
			PopUpManager.removePopUp(_progressDialog);
			Alert.show("保存が完了しました", "保存完了");
		}
		
		/**
		 * プログレスダイアログのポップアップ
		 */
		private function popUpProgressDialog():void
		{
			_progressDialog = ProgressDialog(PopUpManager.createPopUp(_view, ProgressDialog, true));
			PopUpManager.centerPopUp(IFlexDisplayObject(_progressDialog));
		}
		
	}
}