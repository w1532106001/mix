abstract class MvpView {
  showLoading();

  showLoadingWithMessage(String message);

  showError();

  showErrorWithMessage(String message);

  showMessage(String message);

  showProgressDialog(String message);

  hideProgressDialog();
}
