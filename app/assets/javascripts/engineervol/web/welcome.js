var height = $(window).height() * 0.9
var width = height * 0.704 * 2

function turnPageTo(page) {
  $flipbook = $('#flipbook');
  const pagesToTurn = page - $flipbook.turn('page');
  const turnActions = Math.abs(pagesToTurn / 2);
  if (turnActions > 10) {
    $flipbook.turn('page', page);
  } else {
    for (let turn = 0; turn < turnActions; turn++) {
      setTimeout(function() {
        if (pagesToTurn > 0) {
          $flipbook.turn('next');
        } else {
          $flipbook.turn('previous');
        }
      }, 350 * turn);
    } 
  } 
}

window.addEventListener('load', function(){
  $flipbook = $('#flipbook');
  $flipbook.turn({
    width: width,
    height: height,
    autoCenter: true
  });

  const $description = $('#description');
  $flipbook.bind('start', function(event, page, view) {
    if (page.page == 1) {
      $description.css('z-index', '-1');
    }
  });
  $flipbook.bind('turned', function(event, page, view) {
    if (page == 1) {
      $description.css('z-index', '999');
    }
  });
  $description.width(width / 3);
  $description.css('top', `${height / 3}px`);
  $description.css('left', `${width / 16}px`);

  const $buttons = $('#buttons');
  $buttons.width(width / 4);
  $buttons.css('top', `${height / 4}px`);
  $buttons.css('right', `${width / 8}px`);

  const $turnThePage = $('#turnThePage');
  $turnThePage.css('bottom', '100px');
  $turnThePage.css('right', `${width / 8}px`);

  $('button.turn-page').click(function(event) {
    turnPageTo($(event.target).data('page'));
  });
});
