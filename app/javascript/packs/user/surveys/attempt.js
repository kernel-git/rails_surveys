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
        .addClass('question-wrapper__text')
        .text(question_data[1]);
      const answerField = $('<input/>')
        .addClass('question-wrapper__answer-field')
        .attr('type', 'text')
        .attr('name', `answers[${question_data[0]}[answer_val]]`);

      questionWrapper.append(questionLabel, answerField);
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
  //updateQgroupTab();
});

function updateQgroupTab() {
  if (nextButton == null)
    nextButton = $('.next-button').detach();
  $('.content-wrapper').prepend(qgroups[current_qgroup_index]);
}
