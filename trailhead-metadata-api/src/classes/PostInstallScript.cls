public class PostInstallScript implements InstallHandler {
    
    // Deploy post-install metadata  
    public void onInstall(InstallContext context) {
        DeployMetadata deployUtil = new DeployMetadata();
        Metadata.DeployContainer container = deployUtil.constructDeploymentRequest();
        deployUtil.deploy(container);
    }
}