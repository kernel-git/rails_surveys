let free_qgroup_ids = [0]
let free_question_ids = [0]
let free_option_ids = [0]
let add_button

$(document).ready(() => {
  add_button = $('#add_button').detach();
  $('#add_qgroup').on('click', () => {
    addNewQuestionGroup(free_qgroup_ids[0]);
    if (free_qgroup_ids.length == 1)
      free_qgroup_ids[0] += 1;
    else
      free_qgroup_ids.splice(0, 1);
  });
});

function addNewQuestionGroup(qgroup_id) {
  const qgroupWrapper = $('<div></div>')
    .attr('id', `qgroup_${qgroup_id}`)
    .addClass('colored-group');
  const qgroupLabelWrapper = $('<div></div>')
    .addClass('colored-group__label-wrapper');
  const qgroupLabelInput = $('<input/>')
    .addClass('colored-group__label-text-field')
    .attr('type', 'text')
    .attr('name', 'question_groups[][label]')
    .attr('placeholder', 'New question group');
  const newDeleteButton = $('<div></div>')
    .addClass('table-row-wrapper__information link-button')
    .text('Delete')
    .on('click', () => {
      free_qgroup_ids.unshift(qgroup_id);
      $(`#listing-table_${qgroup_id + 1} [id^="question_"]`).each((index, element) => {
        free_question_ids.unshift(element.id.split('_')[1]);
      });
      $(`#qgroup_${qgroup_id}`).remove();
    });
  qgroupLabelWrapper.append(qgroupLabelInput, newDeleteButton);

  const questionsLabel = $('<div></div>')
    .addClass('model-info-wrapper__label')
    .text('Questions');
  
  const questionsWrapper = $('<div></div>')
    .attr('id', `qgroup_${qgroup_id}_questions_wrapper`);

  const questionAddButton = $('<div><div/>')
    .text('Add new question')
    .addClass('add-button')
    .attr('id', `add_question_to_qgroup_${qgroup_id}`)
    .on('click', () => {
      addNewQuestion(free_question_ids[0], qgroup_id);
      if (free_question_ids.length == 1)
        free_question_ids[0] += 1;
      else
        free_question_ids.splice(0, 1);
    });
  
  
  // const questionsLabel = $('<div></div>')
  //   .addClass('model-table-wrapper__label')
  //   .text('Questions');
  // const tableWrapper = $('<div></div>')
  //   .attr('id', `listing-table_${qgroup_id + 1}`)
  //   .addClass('model-table-wrapper__table custom-table');
  // const headerWrapper = $('<div></div>')
  //   .addClass('custom-table__table-header-wrapper table-header-wrapper');
  // const headerElem1 = $('<div></div>')
  //   .addClass('table-header-wrapper__table-header-element table-header-element');
  // const headerLabel1 = $('<div></div>')
  //   .addClass('table-header-element__label')
  //   .text('Quesetion type');
  // headerElem1.append(headerLabel1);
  // const headerElem2 = $('<div></div>')
  //   .addClass('w-10 table-header-wrapper__table-header-element table-header-element');
  // const headerLabel2 = $('<div></div>')
  //   .addClass('table-header-element__label');
  // headerElem2.append(headerLabel2);
  // headerWrapper.append(headerElem1, headerElem2);

  // add_button
  //   .attr('id', `add-row_${qgroup_id + 1}`)
  //   .on('click', () => {
  //     addNewQuestion(free_question_ids[0], qgroup_id);
  //     if (free_question_ids.length == 1)
  //       free_question_ids[0] += 1;
  //     else
  //       free_question_ids.splice(0, 1);
  //   });

  questionsWrapper.append(questionAddButton);
  qgroupWrapper.append(qgroupLabelWrapper, questionsLabel, questionsWrapper);

  $('#current-qgroups-wrapper').append(qgroupWrapper);
}

function addNewQuestion(question_id, qgroup_id) {
  const addQuestionButton = $(`#add_question_to_qgroup_${qgroup_id}`).detach();

  const questionWrapper = $('<div></div>')
    .addClass('qgroup-wrapper__question-wrapper question-wrapper')
    .attr('id', `question_${question_id}`);
  const questionHeader = $('<div></div')
    .addClass('question-wrapper__header');
  const questionLabelInput = $('<input/>')
    .addClass('colored-group__label-text-field')
    .attr('type', 'text')
    .attr('name', 'question_groups[][questions[][question_type]]')
    .attr('placeholder', 'New question');
  const newDeleteButton = $('<div></div>')
    .addClass('question-wrapper__header-delete-button link-button')
    .text('Delete')
    .on('click', () => {
      free_question_ids.unshift(question_id);
      $(`#question_${question_id}`).remove();
    });
  questionHeader.append(questionLabelInput, newDeleteButton);
    
  const optionsWrapper = $('<div></div>')
    .addClass('model-wrapper__model-table-wrapper model-table-wrapper');

  const optionsLabel = $('<div></div>')
    .addClass('model-table-wrapper__label')
    .text('Options');
  const tableWrapper = $('<div></div>')
    .attr('id', `listing-table_${question_id + 1}`)
    .addClass('model-table-wrapper__table custom-table');
  const headerWrapper = $('<div></div>')
    .addClass('custom-table__table-header-wrapper table-header-wrapper');
  // const headerElem1 = $('<div></div>')
  //   .addClass('table-header-wrapper__table-header-element table-header-element');
  // const headerLabel1 = $('<div></div>')
  //   .addClass('table-header-element__label')
  //   .text('Option text');
  // headerElem1.append(headerLabel1);
  // const headerElem2 = $('<div></div>')
  //   .addClass('table-header-wrapper__table-header-element table-header-element');
  // const headerLabel2 = $('<div></div>')
  //   .addClass('table-header-element__label')
  //   .text('With text field');
  // headerElem2.append(headerLabel2);
  const headerElem = $('<div></div>')
    .addClass('table-header-wrapper__table-header-element table-header-element');
  const headerLabel = $('<div></div>')
    .addClass('table-header-element__label')
    .text('Options');
  headerElem.append(headerLabel);
  headerWrapper.append(headerElem);

  const optionAddButton = add_button.clone();
  optionAddButton
    .attr('id', `add-row_${question_id + 1}`)
    .on('click', () => {
      addNewOption(free_option_ids[0], question_id);
      if (free_option_ids.length == 1)
        free_option_ids[0] += 1;
      else
        free_option_ids.splice(0, 1);
    });
  tableWrapper.append(headerWrapper, optionAddButton);
  optionsWrapper.append(optionsLabel, tableWrapper);

  questionWrapper.append(questionHeader, optionsWrapper);

  $(`#qgroup_${qgroup_id}_questions_wrapper`).append(questionWrapper, addQuestionButton);


  // const rowWrapper = $('<div></div>')
  //   .attr('id', `question_${question_id}`)
  //   .addClass('custom-table__table-row-wrapper table-row-wrapper');
  // const questionLabel = $('<input/>')
  //   .attr('type', 'text')
  //   .attr('name', 'question_groups[][question_group[questions[][question[question_type]]]]')
  //   .addClass('table-row-wrapper__text-input');
  // const newDeleteButton = $('<div></div>')
  //   .addClass('table-row-wrapper__information link-button')
  //   .text('Delete')
  //   .on('click', () => {
  //     free_question_ids.unshift(question_id);
  //     $(`#question_${question_id}`).remove();
  //   });
  // rowWrapper.append(questionLabel, newDeleteButton);
  // const addButton = $(`#add-row_${qgroup_id + 1}`).detach();

  // $(`#listing-table_${qgroup_id + 1}`).append(rowWrapper);
  // $(`#listing-table_${qgroup_id + 1}`).append(addButton);
}

function addNewOption(option_id, question_id) {
  console.log(`Option id: ${option_id}`);
  const optionWrapper = $('<div></div>')
    .attr('id', `option_${option_id}`)
    .addClass('custom-table__table-row-wrapper table-row-wrapper');
  const optionLabel = $('<input/>')
    .attr('type', 'text')
    .attr('placeholder', 'New option')
    .attr('name', 'question_groups[][questions[][options[][label]]')
    .addClass('table-row-wrapper__text-input');
  const optionCheckboxWrapper = $('<div></div>')
    .addClass('table-row-wrapper__checkbox-wrapper');
  const checkboxText = $('<div></div>')
    .addClass('table-row-wrapper__checkbox-label')
    .text('Should be with text field?');
  const optionCheckbox = $('<input/>')
    .attr('type', 'checkbox')
    .attr('name', 'question_groups[][questions[][options[][with_text_field]]')
    .addClass('table-row-wrapper__checkbox');
  optionCheckboxWrapper.append(checkboxText, optionCheckbox);
  const newDeleteButton = $('<div></div>')
    .addClass('table-row-wrapper__information link-button')
    .text('Delete')
    .on('click', () => {
      free_option_ids.unshift(option_id);
      $(`#option_${option_id}`).remove();
    });
    optionWrapper.append(optionLabel, optionCheckboxWrapper, newDeleteButton);
  const addButton = $(`#add-row_${question_id + 1}`).detach();

  $(`#listing-table_${question_id + 1}`).append(optionWrapper);
  $(`#listing-table_${question_id + 1}`).append(addButton);
}