package gps.fillZones;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Configuration {
	private static final String PROPERTY_FILE_NAME = "setup.properties";
    private Properties p = new Properties();

    public Configuration() throws IOException {
    	Properties p = new Properties();
    	System.out.println(getClass().getResourceAsStream(PROPERTY_FILE_NAME));
		InputStream systemResourceAsStream = getClass().getClassLoader()
				.getResourceAsStream(PROPERTY_FILE_NAME);
		try {
			p.load(systemResourceAsStream);
		} catch (IOException e1) {
			return;
		}
    }
    
    public Properties getConfiguration() {
        return p;
    }
}
