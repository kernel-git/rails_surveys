let qgroups = [];
let current_qgroup_index = null;
let nextButton = null;

$(document).ready(() => {
  current_qgroup_index = 0;
  // nextButton = $('.next-button').detach();
  // nextButton.attr('name', 'commit');

  $('.qgroup-wrapper').hide();
  $(`#qgroup_0`).show();

  $('[id^="progress_"]').on('click', (self) => {
    let index = self.currentTarget.id.split("_")[1];
    $('.qgroup-wrapper').hide();
    $(`#qgroup_${index}`).show();
    updateQgroupTab();
  });

  // Attaching click event handlers to all radio buttons...
  $('input[type="radio"]').on('click', function(){
    // Processing only those that match the name attribute of the currently clicked button...
    $('input[name="' + $(this).attr('name') + '"]').not($(this)).trigger('deselect'); // Every member of the current radio group except the clicked one...
  });

  $('[id^="radio_with_field_"]').on('click', (self) => {
      let id = self.currentTarget.id.split("_")[3];
      let question_id = $(`#radio_with_field_${id}`).attr('name').split(/[\[\]]/)[1];
      console.log(`question_id: ${question_id}`);
      $(`#field_${id}`).attr('name', `answers[${question_id}][additional_text]`);
      $(`#field_${id}`).addClass('answer-option-wrapper__text-field--active');
  });

  $('[id^="radio_with_field_"]').on('deselect', (self) => {
    let id = self.currentTarget.id.split("_")[3];
    $(`#field_${id}`).attr('name', '');
    $(`#field_${id}`).removeClass('answer-option-wrapper__text-field--active');
  });
});

function updateQgroupTab() {
  // if (nextButton == null)
  //   nextButton = $('.next-button').detach();
  $('.content-wrapper').prepend(qgroups[current_qgroup_index]);
}
