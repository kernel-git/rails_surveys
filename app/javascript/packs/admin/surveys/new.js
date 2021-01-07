let free_qgroup_ids = [0]
let free_question_ids = [0]
let free_option_ids = [0]
let add_button

let employersData = [];
let hiddenEmployersData = [];
let currentEmployerIndex = null;
let addEmployerButton = null;


$(document).ready(() => {
  add_button = $('#add_button').detach();
  $('#add_qgroup').on('click', () => {
    addNewQuestionGroup(free_qgroup_ids[0]);
    if (free_qgroup_ids.length == 1)
      free_qgroup_ids[0] += 1;
    else
      free_qgroup_ids.splice(0, 1);
  });
  
  let employers_data = $('#employers_data').data('employers');

  employers_data.forEach((employer_data, index) => {  // adding html to employer modal
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_2`)
      .on('click', () => {
        console.log('Employer modal clicked!')
        currentEmployerIndex = index;
        updateEmployerTables();
        closeModal(0);
      });
    const newLogoWrapper = $('<div></div>')
      .addClass('table-row-wrapper__information')
    const newLogo = $('<img>')
      .attr('src', employer_data[1])
      .attr('width', '75')
      .attr('height', '75');

    newLogoWrapper.append(newLogo);
    
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employer_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employer_data[3]);

    newRow.append(newLogoWrapper, newLabel, newEmail);
    $(`#listing-table_1`).append(newRow);
  });

  employers_data.forEach((employer_data, index) => {  // filling employersData with html  
    const newRow = $('<div></div>')
      .addClass(`custom-table__table-row-wrapper table-row-wrapper`)
      .attr('id', `row_${index}_table_0`);
    const newLogoWrapper = $('<div></div>')
      .addClass('table-row-wrapper__information')
    const newLogo = $('<img>')
      .attr('src', employer_data[1])
      .attr('width', '75')
      .attr('height', '75');

    newLogoWrapper.append(newLogo);
    
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employer_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employer_data[3]);

    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        console.log('Employer delete clicked!');
        currentEmployerIndex = null;
        updateEmployerTables();
      });

    newRow.append(newLogoWrapper, newLabel, newEmail, newDeleteButton);
    employersData.push(newRow)
  });

  employers_data.forEach((employer_data, index) => {  // filling hiddenEmployersData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `employer_${employer_data[0]}`)
      .attr('name', 'employer_id')
      .attr('type', 'hidden')
      .val(employer_data[0]);

    hiddenEmployersData.push($('#current_employer_id').append(newHiddenInputSegment));
  });

  updateEmployerTables();

  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });
});

function updateEmployerTables() {
  if (addEmployerButton == null)
    addEmployerButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#current-employer-id').empty();

  $('#listing-table_0').append(employersData[currentEmployerIndex]);
  if (currentEmployerIndex == null)
    $('#listing-table_0').append(addEmployerButton);

  $('#current-employer-id').append(hiddenEmployersData[currentEmployerIndex]);
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}

function addNewQuestionGroup(qgroup_id) {
  const qgroupWrapper = $('<div></div>')
    .attr('id', `qgroup_${qgroup_id}`)
    .addClass('colored-group');
  const qgroupLabelWrapper = $('<div></div>')
    .addClass('colored-group__label-wrapper');
  const qgroupLabel = $('<div></div>')
    .addClass('colored-group__label')
    .text('Question Group');
  const newDeleteButton = $('<div></div>')
    .addClass('table-row-wrapper__information link-button')
    .text('Delete')
    .on('click', () => {
      free_qgroup_ids.unshift(qgroup_id);
      $(`#listing-table_${qgroup_id + 2} [id^="question_"]`).each((index, element) => {
        free_question_ids.unshift(element.id.split('_')[1]);
      });
      $(`#qgroup_${qgroup_id}`).remove();
    });
  qgroupLabelWrapper.append(qgroupLabel, newDeleteButton);
  const modelGroup = $('<div></div>')
    .addClass('model-wrapper__model-group');
  const modelInfoBlock = $('<div></div>')
    .addClass('model-wrapper__model-info-block');
  const modelInfoWrapper = $('<div></div>')
    .addClass('model-wrapper__model-info-wrapper');
  const infoLabel = $('<div></div>')
    .addClass('model-info-wrapper__label')
    .text('Label:');
  const infoInput = $('<input/>')
    .addClass('model-info-wrapper__info')
    .attr('type', 'text')
    .attr('name', 'question_groups[][label]');
  modelInfoWrapper.append(infoLabel, infoInput);
  modelInfoBlock.append(modelInfoWrapper);
  modelGroup.append(modelInfoBlock);

  const questionsLabel = $('<div></div>')
    .addClass('model-info-wrapper__label')
    .text('Questions');
  
  const questionsWrapper = $('<div></div>')
    .addClass('model-wrapper__model-table-wrapper model-table-wrapper')
    .attr('id', `qgroup_${qgroup_id}_questions_wrapper`);

  const questionAddButton = $('<div><div/>')
    .text('Add new question')
    .addClass('link-button')
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
  //   .attr('id', `listing-table_${qgroup_id + 2}`)
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
  //   .attr('id', `add-row_${qgroup_id + 2}`)
  //   .on('click', () => {
  //     addNewQuestion(free_question_ids[0], qgroup_id);
  //     if (free_question_ids.length == 1)
  //       free_question_ids[0] += 1;
  //     else
  //       free_question_ids.splice(0, 1);
  //   });

  questionsWrapper.append(questionAddButton);
  qgroupWrapper.append(qgroupLabelWrapper, modelGroup, questionsLabel, questionsWrapper);

  $('#current-qgroups-wrapper').append(qgroupWrapper);
}

function addNewQuestion(question_id, qgroup_id) {
  const questionWrapper = $('<div></div>')
    .addClass('qgroup-wrapper__question-wrapper question-wrapper')
    .attr('id', `question_${question_id}`);
  const questionHeader = $('<div></div')
    .addClass('question-wrapper__header');
  const questionLabelWrapper = $('<div></div')
  .addClass('question-wrapper__header-label-wrapper');
  const questionLabelText = $('<div></div')
    .addClass('question-wrapper__header-label-text')
    .text('Label:');
  const questionLabelInput = $('<input/>')
    .addClass('question-wrapper__header-label-input')
    .attr('type', 'text')
    .attr('name', 'question_groups[][questions[][question_type]]');
  questionLabelWrapper.append(questionLabelText, questionLabelInput);
  const newDeleteButton = $('<div></div>')
    .addClass('question-wrapper__header-delete-button link-button')
    .text('Delete')
    .on('click', () => {
      free_question_ids.unshift(question_id);
      $(`#question_${question_id}`).remove();
    });
  questionHeader.append(questionLabelWrapper, newDeleteButton);
    
  const optionsWrapper = $('<div></div>')
    .addClass('model-wrapper__model-table-wrapper model-table-wrapper');

  const optionsLabel = $('<div></div>')
    .addClass('model-table-wrapper__label')
    .text('Options');
  const tableWrapper = $('<div></div>')
    .attr('id', `listing-table_${question_id + 2}`)
    .addClass('model-table-wrapper__table custom-table');
  const headerWrapper = $('<div></div>')
    .addClass('custom-table__table-header-wrapper table-header-wrapper');
  const headerElem1 = $('<div></div>')
    .addClass('table-header-wrapper__table-header-element table-header-element');
  const headerLabel1 = $('<div></div>')
    .addClass('table-header-element__label')
    .text('Option text');
  headerElem1.append(headerLabel1);
  const headerElem2 = $('<div></div>')
    .addClass('table-header-wrapper__table-header-element table-header-element');
  const headerLabel2 = $('<div></div>')
    .addClass('table-header-element__label')
    .text('With text field');
  headerElem2.append(headerLabel2);
  const headerElem3 = $('<div></div>')
    .addClass('w-10 table-header-wrapper__table-header-element table-header-element');
  const headerLabel3 = $('<div></div>')
    .addClass('table-header-element__label');
  headerElem3.append(headerLabel3);
  headerWrapper.append(headerElem1, headerElem2, headerElem3);

  const optionAddButton = add_button.clone();
  optionAddButton
    .attr('id', `add-row_${question_id + 2}`)
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

  $(`#qgroup_${qgroup_id}_questions_wrapper`).append(questionWrapper);
  


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
  // const addButton = $(`#add-row_${qgroup_id + 2}`).detach();

  // $(`#listing-table_${qgroup_id + 2}`).append(rowWrapper);
  // $(`#listing-table_${qgroup_id + 2}`).append(addButton);
}

function addNewOption(option_id, question_id) {
  console.log(`Option id: ${option_id}`);
  const optionWrapper = $('<div></div>')
    .attr('id', `option_${option_id}`)
    .addClass('custom-table__table-row-wrapper table-row-wrapper');
  const optionLabel = $('<input/>')
    .attr('type', 'text')
    .attr('name', 'question_groups[][questions[][options[][label]]')
    .addClass('table-row-wrapper__text-input');
  const optionCheckbox = $('<input/>')
    .attr('type', 'checkbox')
    .attr('name', 'question_groups[][questions[][options[][with_text_field]]')
    .addClass('table-row-wrapper__checkbox');
  const newDeleteButton = $('<div></div>')
    .addClass('table-row-wrapper__information link-button')
    .text('Delete')
    .on('click', () => {
      free_option_ids.unshift(option_id);
      $(`#option_${option_id}`).remove();
    });
    optionWrapper.append(optionLabel, optionCheckbox, newDeleteButton);
  const addButton = $(`#add-row_${question_id + 2}`).detach();

  $(`#listing-table_${question_id + 2}`).append(optionWrapper);
  $(`#listing-table_${question_id + 2}`).append(addButton);
}