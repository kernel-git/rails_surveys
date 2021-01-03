let free_qgroup_ids = [0]
let free_question_ids = [0]
let add_button

$(document).ready(() => {
  add_button = $('#add_button').detach()
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
  const qgroupLabel = $('<div></div>')
    .addClass('colored-group__label')
    .text('Question Group');
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
    .attr('id', `listing-table_${qgroup_id + 1}`)
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

  add_button
    .attr('id', `add-row_${qgroup_id + 1}`)
    .on('click', () => {
      addNewQuestion(free_question_ids[0], qgroup_id);
      if (free_question_ids.length == 1)
        free_question_ids[0] += 1;
      else
        free_question_ids.splice(0, 1);
    });

  tableWrapper.append(headerWrapper, add_button);
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
  const addButton = $(`#add-row_${qgroup_id + 1}`).detach();

  $(`#listing-table_${qgroup_id + 1}`).append(rowWrapper);
  $(`#listing-table_${qgroup_id + 1}`).append(addButton);
}