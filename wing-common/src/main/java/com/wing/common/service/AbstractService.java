package com.wing.common.service;

import com.wing.common.util.LogUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 线程安全
 * 
 * 
 */
public abstract class AbstractService {

	enum State {
		STATE_NEW, STATE_STARTING, STATE_RUNNING, STATE_PAUSING, STATE_PAUSED, STATE_RESUMING, STATE_STOPPING, STATE_TERMINATED
	}

	static class ShutdownThread extends Thread {
		private final AbstractService service;

		public ShutdownThread(AbstractService service) {
			this.service = service;
			this.setName("ShutdownHook");
		}

		@Override
		public void run() {
			if (service != null && !service.isStoppingOrTerminated()) {
				service.stop();
			}
		}
	}
	public abstract String getServiceName();
	private volatile State state = State.STATE_NEW;
	protected final String[] args;

	public AbstractService(String[] args) {
		this.args = args;

		// 设置shutdown hook
		Runtime.getRuntime().addShutdownHook(new ShutdownThread(this));
	}

	protected abstract void onStart() throws Exception;

	protected abstract void onRun() throws Exception;

	protected abstract void onStop() throws Exception;

	protected abstract void onPause() throws Exception;

	protected abstract void onResume() throws Exception;

	public State getState() {
		return state;
	}

	public boolean isRunning() {
		return state == State.STATE_RUNNING;
	}

	public boolean isStoppingOrTerminated() {
		return state == State.STATE_STOPPING || state == State.STATE_TERMINATED;
	}

	public void start() {
		LogUtil.info("starting {} service",this.getServiceName());
		long startTime = System.currentTimeMillis();

		if (state != State.STATE_NEW) {
			LogUtil.error("invalid state: {}", state);
			return;
		}

		state = State.STATE_STARTING;
		try {
			onStart();
			state = State.STATE_RUNNING;
			LogUtil.info("{} is running, delta={} ms", getServiceName(), (System.currentTimeMillis() - startTime));
			System.out.println(getServiceName()+" is running,delta="+(System.currentTimeMillis() - startTime)+" ms");
			onRun();
		} catch (Exception e) {
			LogUtil.error("failed to starting service: " + getServiceName(), e);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				LogUtil.error("failed to starting service: " + getServiceName(), e);
			}
			System.exit(1);
			return;
		}
	}

	public void stop() {
		LogUtil.info("stopping service: {}", getServiceName());
		if (state == State.STATE_NEW || state == State.STATE_STOPPING || state == State.STATE_TERMINATED) {
			LogUtil.error("invalid state: {}", state);
			return;
		}

		state = State.STATE_STOPPING;
		try {
			onStop();
			state = State.STATE_TERMINATED;
			LogUtil.info("goodbye {}", getServiceName());
			System.out.println("goodbye "+getServiceName());
		} catch (Throwable e) {
			LogUtil.error("failed to stopping service: " + getServiceName(), e);
			return;
		}

	}

	public void pause() {
		LogUtil.info("pausing service: {}", getServiceName());
		if (state != State.STATE_RUNNING) {
			LogUtil.error("invalid state: {}", state);
			return;
		}

		state = State.STATE_PAUSING;
		try {
			onPause();
			state = State.STATE_PAUSED;
		} catch (Exception e) {
			LogUtil.error("failed to pausing service: " + getServiceName(), e);
			return;
		}

	}

	public void resume() {
		LogUtil.info("resuming service: {}", getServiceName());
		if (state != State.STATE_PAUSED) {
			LogUtil.error("invalid state: {}", state);
			return;
		}

		state = State.STATE_RESUMING;
		try {
			onResume();
			state = State.STATE_RUNNING;
		} catch (Exception e) {
			LogUtil.error("failed to resuming service: " + getServiceName(), e);
			return;
		}

	}

}
