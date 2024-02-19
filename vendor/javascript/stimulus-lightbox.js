import{Controller as t}from"@hotwired/stimulus";import e from"lightgallery";class l extends t{connect(){this.lightGallery=e(this.element,{...this.defaultOptions,...this.optionsValue})}disconnect(){this.lightGallery.destroy()}get defaultOptions(){return{}}}l.values={options:Object};export{l as default};

