let modalEvent = function() {
  let source = Rx.Observable.fromEvent($('.destroy-category-btn'), 'click')
  let $modal = $('#destroy-modal')
  let $modalContent = $('#destroy-modal-content')  
  let $resolve = $('#modal-yes')
  let $reject = $('#modal-no')
  let getData = event => event.target.dataset
  let openModal = data => {
    $modalContent.children('span').text(data.title)
    $resolve.attr('href', data.url)
    $modal.fadeIn(250)
  }
  source
    .map(getData)
    .subscribe(openModal)

  let $closeModalBtn = $('.backend-modal-close-btn')
  let closeModalSource = Rx.Observable.fromEvent($closeModalBtn, 'click')
  let closeModal = event => $modal.fadeOut(250)
  closeModalSource.subscribe(closeModal)

  let modalRejection = Rx.Observable.fromEvent($reject, 'click')
  modalRejection.subscribe(closeModal)
}
$(document).ready(modalEvent)
