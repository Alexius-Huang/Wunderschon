/*
 *= require rxjs/bundles/Rx.min.js
 */
var modalEvent = function() {
  var source = Rx.Observable.fromEvent($('.destroy-product-btn'), 'click');
  var $modal = $('#destroy-modal');
  var $modalContent = $('#destroy-modal-content');
  var $resolve = $('#modal-yes');
  var $reject = $('#modal-no');
  var getData = function(event) { return event.target.dataset; }
  var openModal = function(data) {
    $modalContent.children('span').text(data.title);
    $resolve.attr('href', data.url);
    $modal.fadeIn(250)
  }
  source
    .map(getData)
    .subscribe(openModal);

  var $closeModalBtn = $('.backend-modal-close-btn');
  var closeModalSource = Rx.Observable.fromEvent($closeModalBtn, 'click');
  var closeModal = function(event) { $modal.fadeOut(250); }
  closeModalSource.subscribe(closeModal);

  var modalRejection = Rx.Observable.fromEvent($reject, 'click');
  modalRejection.subscribe(closeModal)
}
$(document).ready(modalEvent);
$(document).on('turbolinks:load', modalEvent);