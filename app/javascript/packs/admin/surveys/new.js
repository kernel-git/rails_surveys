let free_qgroup_id = 0
let free_question_id = 0

$(document).ready(() => {
  $('#add_qgroup').on('click', () => {
    addNewQuestionGroup(free_qgroup_id);
    free_qgroup_id += 1;
  });
});

function addNewQuestionGroup(qgroup_id) {
  const qgroupWrapper = $('<div></div>')
    .attr('id', `qgroup_${qgroup_id}_wrapper`);
  const qgroupHeader = $('<h3></h3>')
    .text('Question Group');
  const qgroupLabelHeader = $('<h4></h4>')
    .text('Label');
  const qgroupLabelInput = $('<input/>')
    .attr('type', 'text')
    .attr('name', 'survey[question_groups[][question_group[label]]]');
  const questionsLabel = $('<h3></h3>')
    .text('Questions');
  const qgroupQuestionsWrapper = $('<div></div>')
    .attr('id', `questions_${qgroup_id}`)
  const qgroupAddQuestion = $('<button></button>')
    .attr('id', `add_question_${qgroup_id}`)
    .text('Add new question')
    .on('click', () => {
      addNewQuestion(free_question_id, qgroup_id);
      free_question_id += 1;
    });
  qgroupWrapper.append(qgroupHeader, qgroupLabelHeader, qgroupLabelInput,
    questionsLabel, qgroupQuestionsWrapper, qgroupAddQuestion);
  $('#current_qgroups_wrapper').append(qgroupWrapper);
}

function addNewQuestion(question_id, qgroup_id) {
  const questionWrapper = $('<div></div>')
    .attr('id', `question_${question_id}_wrapper`);
  const questionHeader = $('<h3></h3>')
    .text('Question');
  const questionLabelHeader = $('<h4></h4>')
    .text('Question type:');
  const questionLabelInput = $('<input/>')
    .attr('type', 'text')
    .attr('name', 'survey[question_groups[][question_group[questions[][question[question_type]]]]]');
  questionWrapper.append(questionHeader, questionLabelHeader, questionLabelInput);
  $(`#questions_${qgroup_id}`).append(questionWrapper);
}