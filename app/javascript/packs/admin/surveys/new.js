let free_qgroup_ids = [0]
let free_question_ids = [0]

let employersData = [];
let hiddenEmployersData = [];
let currentEmployerIndex = null;
let addEmployerButton = null;


$(document).ready(() => {
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

  $('#add_qgroup').on('click', () => {
    addNewQuestionGroup(free_qgroup_ids[0]);
    if (free_qgroup_ids.length == 1)
      free_qgroup_ids[0] += 1;
    else
      free_qgroup_ids.splice(0, 1);
  });

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
    .attr('name', 'question_groups[][question_group[label]]');
  modelInfoWrapper.append(infoLabel, infoInput);
  modelInfoBlock.append(modelInfoWrapper);
  modelGroup.append(modelInfoBlock);

  const questionsWrapper = $('<div></div>')
    .addClass('model-wrapper__model-table-wrapper model-table-wrapper');
  const questionsLabel = $('<div></div>')
    .addClass('model-table-wrapper__label')
    .text('Questions');
  const tableWrapper = $('<div></div>')
    .attr('id', `listing-table_${qgroup_id + 2}`)
    .addClass('model-table-wrapper__table custom-table');
  const headerWrapper = $('<div></div>')
    .addClass('custom-table__table-header-wrapper table-header-wrapper');
  const headerElem1 = $('<div></div>')
    .addClass('table-header-wrapper__table-header-element table-header-element');
  const headerLabel1 = $('<div></div>')
    .addClass('table-header-element__label')
    .text('Quesetion type');
  headerElem1.append(headerLabel1);
  const headerElem2 = $('<div></div>')
    .addClass('w-10 table-header-wrapper__table-header-element table-header-element');
  const headerLabel2 = $('<div></div>')
    .addClass('table-header-element__label');
  headerElem2.append(headerLabel2);
  headerWrapper.append(headerElem1, headerElem2);

  let addButton = addEmployerButton.clone();
  addButton
    .attr('id', `add-row_${qgroup_id + 2}`)
    .on('click', () => {
      addNewQuestion(free_question_ids[0], qgroup_id);
      if (free_question_ids.length == 1)
        free_question_ids[0] += 1;
      else
        free_question_ids.splice(0, 1);
    });

  tableWrapper.append(headerWrapper, addButton);
  questionsWrapper.append(questionsLabel, tableWrapper);
  qgroupWrapper.append(qgroupLabelWrapper, modelGroup, questionsWrapper);

  $('#current-qgroups-wrapper').append(qgroupWrapper);
}

function addNewQuestion(question_id, qgroup_id) {
  const rowWrapper = $('<div></div>')
    .attr('id', `question_${question_id}`)
    .addClass('custom-table__table-row-wrapper table-row-wrapper');
  const questionLabel = $('<input/>')
    .attr('type', 'text')
    .attr('name', 'question_groups[][question_group[questions[][question[question_type]]]]')
    .addClass('table-row-wrapper__text-input');
  const newDeleteButton = $('<div></div>')
    .addClass('table-row-wrapper__information link-button')
    .text('Delete')
    .on('click', () => {
      free_question_ids.unshift(question_id);
      $(`#question_${question_id}`).remove();
    });
  rowWrapper.append(questionLabel, newDeleteButton);
  const addButton = $(`#add-row_${qgroup_id + 2}`).detach();

  $(`#listing-table_${qgroup_id + 2}`).append(rowWrapper);
  $(`#listing-table_${qgroup_id + 2}`).append(addButton);
}