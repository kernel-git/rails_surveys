let qgroups = [];
let current_qgroup_index = null;
let nextButton = null;

$(document).ready(() => {
  let qgroups_data = $('#qgroups_data').data('qgroups');
  current_qgroup_index = 0;
  nextButton = $('.next-button').detach();
  nextButton.attr('name', 'commit');

  console.log(qgroups_data);


  qgroups_data.forEach((qgroup_data, index) => {
    const qgroupWrapper = $('<div></div>')
      .addClass('qgroup-wrapper')
      .attr('id', `qgroup_${index}`);
    const labelWrapper = $('<div></div>')
      .addClass('qgroup-wrapper__qgroup-label-wrapper qgroup-label-wrapper');
    const qgroupLabel = $('<div></div>')
      .addClass('qgroup-label-wrapper__label font-big')
      .text(qgroup_data[0]);
    labelWrapper.append(qgroupLabel, nextButton.clone());
    qgroupWrapper.append(labelWrapper);
    qgroup_data[1].forEach((question_data, i) => {
      const questionWrapper = $('<div></div>')
        .addClass('qgroup-wrapper__question-wrapper question-wrapper');
      const questionLabel = $('<div></div>')
        .addClass('question-wrapper__text font-big')
        .text(question_data[1]);
      questionWrapper.append(questionLabel);
      question_data[2].forEach((option_data, i) => {
        const optionWrapper = $('<div></div>')
          .addClass('question-wrapper__answer-option-wrapper answer-option-wrapper');
        const optionLabelWrapper = $('<div></div>')
          .addClass('answer-option-wrapper__label-wrapper');
        const optionRadioButton = $('<input/>')
          .attr('type', 'radio')
          .attr('value', option_data[0])
          .attr('name', `answers[${question_data[0]}][option_data]`)
          .addClass('answer-option-wrapper__radio')
        const optionLabel = $('<div></div>')
          .addClass('answer-option-wrapper__label')
          .text(option_data[1]);
        
        let additionalTextField = null;
        if(option_data[2] == true) {
          additionalTextField = $('<input/>')
            .addClass('answer-option-wrapper__text-field')
            .attr('type', 'text')
            .attr('id', `field_${question_data[0]}`);
          optionRadioButton.attr('id', `radio_with_field_${question_data[0]}`); 
        }
        optionLabelWrapper.append(optionRadioButton, optionLabel);
        optionWrapper.append(optionLabelWrapper);
        if(additionalTextField != null)
          optionWrapper.append(additionalTextField);
        questionWrapper.append(optionWrapper);
      });
      // const answerField = $('<input/>')
      //   .addClass('question-wrapper__answer-field')
      //   .attr('type', 'text')
      //   .attr('name', `answers[${question_data[0]}[answer_val]]`);
      // questionWrapper.append(answerField);

      qgroupWrapper.append(questionWrapper);
    });
    $('.content-wrapper').prepend(qgroupWrapper);

    const progressElement = $('<div></div>')
      .addClass('progress__element')
      .text(`${index + 1}`)
      .on('click', () => {
        $('.qgroup-wrapper').hide();
        $(`#qgroup_${index}`).show();
        updateQgroupTab();
      });
    $('.progress__wrapper').append(progressElement);
  });
  $('.content-footer').append(nextButton);

  $('.qgroup-wrapper').hide();
  $(`#qgroup_0`).show();

  // Attaching click event handlers to all radio buttons...
  $('input[type="radio"]').on('click', function(){
    // Processing only those that match the name attribute of the currently clicked button...
    $('input[name="' + $(this).attr('name') + '"]').not($(this)).trigger('deselect'); // Every member of the current radio group except the clicked one...
  });

  $('[id^="radio_with_field_"]').on('click', (self) => {
      let id = self.currentTarget.id.split("_")[3];
      $(`#field_${id}`).attr('name', `answers[${id}[additional_text]]`);
      $(`#field_${id}`).addClass('answer-option-wrapper__text-field--active');
  });

  $('[id^="radio_with_field_"]').on('deselect', (self) => {
    let id = self.currentTarget.id.split("_")[3];
    $(`#field_${id}`).attr('name', '');
    $(`#field_${id}`).removeClass('answer-option-wrapper__text-field--active');
  });
});

function updateQgroupTab() {
  if (nextButton == null)
    nextButton = $('.next-button').detach();
  $('.content-wrapper').prepend(qgroups[current_qgroup_index]);
}
