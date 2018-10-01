public class PostInstallCallback implements Metadata.DeployCallback {
  
    public void handleResult(Metadata.DeployResult result,
        Metadata.DeployCallbackContext context) {
        
        if (result.status == Metadata.DeployStatus.Succeeded) {
            // Deployment was successful, take appropriate action.
            System.debug('Deployment Succeeded!');
        } else {
            // Deployment wasn’t successful, take appropriate action.
	    System.debug('Deployment Failed!');
        }
    }
}