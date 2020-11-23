//const { $ } = require('@rails/ujs');

let currentSegments = [];

$(document).ready(() => {
  let segments_data = $('#segments_data').data('segments');
  segments_data.forEach(addOptionToSelect);

  $('#add_selected_segment').click(() => {
    const selectedValue = $('#new_segment_select').val();
    const selectedText = $('#new_segment_select option:selected').text();

    currentSegments.push([selectedValue, selectedText]);

    const newSegmentWrapper = $('<div></div>').attr('id', `segment_${selectedValue}_wrapper`);
    const newSegmentLabel = $('<h4></h4>').text(selectedText);
    const newSegmentDelete = $('<h3></h3>')
      .attr('id', `segment_${selectedValue}_delete`)
      .text('Delete');
    newSegmentWrapper.append(newSegmentLabel, newSegmentDelete);
    $('#current_segment_labels').append(newSegmentWrapper);

    $(`#segment_${selectedValue}_delete`).on('click', function(){
      const deleteId = $(this).parent().attr('id').split('_')[1];
      const deleteSegmentData = currentSegments.find((elem) => elem[0] == deleteId);
      currentSegments.splice(currentSegments.indexOf(deleteSegmentData), 1);
      addOptionToSelect(deleteSegmentData);
      $(`#segment_${deleteSegmentData[0]}_wrapper`).remove();
      $(`#segment_${deleteSegmentData[0]}`).remove();
    })

    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `segment_${selectedValue}`)
      .attr('name', 'segments_ids[]')
      .attr('type', 'hidden')
      .val(selectedValue);
    $('#current_segments_ids').append(newHiddenInputSegment);

    $('#new_segment_select option:selected').remove();
  });
});

function addOptionToSelect(value){
  const newOption = $('<option></option>')
    .attr('value', value[0])
    .text(value[1]);
  $('#new_segment_select').append(newOption);
}
