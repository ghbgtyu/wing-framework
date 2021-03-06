package com.mokylin.cabal.common.persistence.dynamicDataSource;



public class LookupContext {

	private static ThreadLocal<String> _serverId = new ThreadLocal();

	private static ThreadLocal<String> serverKey = new ThreadLocal<String>();

	public static void setCurrentServerId(String serverId) {
		_serverId.set(serverId);
	}
	public static String getCurrentServerId() {
		return _serverId.get();
	}

	public static void setServerKey(String serverKey) {
		LookupContext.serverKey.set(serverKey+"_");
	}
	
}
