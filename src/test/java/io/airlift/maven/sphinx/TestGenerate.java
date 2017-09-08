package io.airlift.maven.sphinx;

import com.google.common.io.Files;
import io.takari.maven.testing.TestResources;
import io.takari.maven.testing.executor.MavenRuntime;
import io.takari.maven.testing.executor.MavenRuntime.MavenRuntimeBuilder;
import io.takari.maven.testing.executor.MavenVersions;
import io.takari.maven.testing.executor.junit.MavenJUnitTestRunner;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import java.io.File;

import static com.google.common.base.Charsets.UTF_8;
import static org.junit.Assert.assertTrue;

@RunWith(MavenJUnitTestRunner.class)
@MavenVersions({"3.3.9", "3.5.0", "3.5.2"})
@SuppressWarnings("JUnitTestNG")
public class TestGenerate
{
    @Rule
    public final TestResources resources = new TestResources();

    public final MavenRuntime maven;

    public TestGenerate(MavenRuntimeBuilder mavenBuilder) throws Exception
    {
        this.maven = mavenBuilder.withCliOptions("-B", "-U").build();
    }

    @Test
    public void testBasic() throws Exception
    {
        File basedir = resources.getBasedir("generate");
        maven.forProject(basedir)
                .execute("package")
                .assertErrorFreeLog();

        File output = new File(basedir, "target/html");

        File index = new File(output, "index.html");
        assertTrue(index.isFile());
        assertTrue(Files.toString(index, UTF_8).contains("<title>"));
    }
}
