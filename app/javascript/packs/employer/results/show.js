$(document).ready(() => {
  $('[id^="qgroup_"]').hide();
  $('#qgroup_0').show();
  $('[id^="qgroup-button_"]').each((index, element) => {
    $(`#qgroup-button_${element.id.split('_')[1]}`).on('click', () => {
      $('[id^="qgroup_"]').hide();
      $(`#qgroup_${element.id.split('_')[1]}`).show();
    });
  });
});
