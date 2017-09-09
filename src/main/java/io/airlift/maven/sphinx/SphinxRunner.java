package io.airlift.maven.sphinx;

import org.python.core.Py;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class SphinxRunner
{
    /*
     * For running sphinx via a forked jvm (or standalone).
     */
    public static void main(String[] args)
            throws ScriptException
    {
        // use headless mode for AWT (prevent "Launcher" app on Mac OS X)
        System.setProperty("java.awt.headless", "true");

        System.exit(run(args));
    }

    public static int run(String[] args)
            throws ScriptException
    {
        String sphinxSourceDirectory = null;
        List<String> sphinxArgs = new ArrayList<String>(Arrays.asList(args));

        for (Iterator<String> it = sphinxArgs.iterator(); it.hasNext(); ) {
            String arg = it.next();
            if ("--sphinxSourceDirectory".equals(arg) && it.hasNext()) {
                // we need to remove it from the argument list as sphinx wouldn't like it
                it.remove();
                sphinxSourceDirectory = it.next();
                it.remove();
                break;
            }
        }
        if (sphinxSourceDirectory == null) {
            throw new IllegalArgumentException("No --sphinxSourceDirectory argument given");
        }

        ScriptEngine engine = new ScriptEngineManager().getEngineByName("python");

        engine.put("sphinx_path", Py.newString(sphinxSourceDirectory));
        engine.eval("import sys");
        engine.eval("sys.path.append(sphinx_path)");

        engine.eval("import os");
        engine.eval("os.environ['LANG'] = 'en_US.UTF-8'");
        engine.eval("os.environ['LC_ALL'] = 'en_US.UTF-8'");

        engine.put("args", sphinxArgs.toArray(new String[sphinxArgs.size()]));
        engine.eval("import sphinx");
        return (Integer) engine.eval("sphinx.build_main(args)");
    }
}
