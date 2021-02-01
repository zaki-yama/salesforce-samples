@IsTest
public class DeploymentTest {
    @IsTest
    static void testDeployment() {
        DeployMetadata deployMd = new DeployMetadata();
        
        Metadata.DeployContainer container = deployMd.constructDeploymentRequest();
        List<Metadata.Metadata> contents = container.getMetadata();
        System.assertEquals(1, contents.size());
        Metadata.Layout md = (Metadata.Layout) contents.get(0);
       
        // Perform various assertions the layout metadata.
        System.assertEquals('Account-Account Layout', md.fullName);
    }
}