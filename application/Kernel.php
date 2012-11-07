<?php
namespace Hoborg\DisplayService;

use Symfony\Component\Config\Loader\LoaderInterface;

/**
 * Hoborg Display Service
 */
class Kernel extends \Symfony\Component\HttpKernel\Kernel {

	protected $cacheDir = null;

	protected $hostDir = null;

	/**
	 * @see Symfony\Component\HttpKernel.KernelInterface::registerBundles()
	 */
	public function registerBundles() {
		$bundles = array(
			new \Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
			new \Symfony\Bundle\MonologBundle\MonologBundle(),
			new \Hoborg\Bundle\CommonsBundle\CommonsBundle(),
			new \Hoborg\Bundle\DisplayServiceBundle\DisplayServiceBundle(),
		);

// 		if (in_array($this->getEnvironment(), array('dev', 'test'))) {
// 			$bundles[] = new \Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
// 		}

		if (empty($this->hostDir)) {
			$this->hostDir = realpath(__DIR__ . '/../');
		}

		if ('test' === $this->getEnvironment()) {
			$bundles[] = new \Behat\BehatBundle\BehatBundle();
		}

		return $bundles;
	}

	/**
	 * @see Symfony\Component\HttpKernel.KernelInterface::registerContainerConfiguration()
	 */
	public function registerContainerConfiguration(LoaderInterface $loader) {
		$loader->load($this->getConfDir() . '/' . $this->getEnvironment() . '/conf.yml');
	}

	/**
	 * Sets host root dir.
	 * Use this method if you want to have multiple hosts and one instance
	 * of hoborg bundles. This Path will be used to get cache, logs and conf
	 * folder for you host.
	 *
	 * @param string $dir
	 */
	public function setHostDir($dir) {
		$this->hostDir = realpath($dir);
	}

	/**
	 * @see Symfony\Component\HttpKernel.Kernel::getCacheDir()
	 */
	public function getCacheDir() {
		return $this->hostDir . '/cache/' . $this->getEnvironment();
	}

	/**
	 * @see Symfony\Component\HttpKernel.Kernel::getLogDir()
	 */
	public function getLogDir() {
		return $this->hostDir . '/logs/' . $this->getEnvironment();
	}

	public function getConfDir() {
		return $this->hostDir . '/conf';
	}

	/**
	 * @see Symfony\Component\HttpKernel.Kernel::getKernelParameters()
	 */
	protected function getKernelParameters() {
		return array_merge(
			parent::getKernelParameters(),
			array(
				'kernel.conf_dir' => $this->getConfDir(),
				'kernel.cache' => $this->getCacheDir(),
			)
		);
	}
}