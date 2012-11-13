<?php
use Hoborg\Bundle\DisplayServiceBundle\Component\Component;
include_once __DIR__ . '/markdown.php';

class Paragraph extends Component {

	public function init() {
		parent::init();
	}

	public function prepareData() {

		parent::prepareData();
		foreach ($this->data->documentElement->childNodes as $component) {
			if ('markdown' === $component->nodeName) {
				$mdFile = $component->getAttribute('file');
				$textNode = $this->data->importNode(
						new DOMElement('text', Markdown(file_get_contents($mdFile))), true);
				$this->data->documentElement->appendChild($textNode);
			}
		}
		unset($component);
	}
}
