<?php
namespace components\grid\header;

use Symfony\Component\EventDispatcher\EventDispatcher;

class Component extends \Hoborg\Bundle\DisplayServiceBundle\Component\Component {

	public function render() {
		$links = $this->data->getElementsByTagName('link');
		if ($links->length < 0) {
			return parent::render();
		}

		$url = $this->provider->getUrl();

		// remove trailing "/index"
		if ('/index' == substr($url, -6)) {
			$url = substr($url, 0, -6);
		}

		if (strpos($url, '/en/blog/') === 0) {
			$url = '/en/blog';
		}

		var_dump($url);

		for ($i = 0; $i < $links->length; $i++) {
			$link = $links->item($i);
			if ($url == $link->getAttribute('href')) {
				$link->setAttribute('active', 'active');
			}
		}

		return parent::render();
	}
}
