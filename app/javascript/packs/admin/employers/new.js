//const { $ } = require('@rails/ujs');

let modalSegmentsData = [];
let currentModalSegmentsIndexes = [];
let segmentsData = [];
let hiddenSegmentsData = [];
let currentSegmentsIndexes = [];
let addSegmentButton = null;

$(document).ready(() => {
  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let segments_data = $('#segments_data').data('segments');

  segments_data.forEach((segment_data, index) => {  // filling modalSegmentsData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_1`)
      .on('click', () => {
        console.log(`Modal segment clicked with index: ${index}`);
        currentSegmentsIndexes.push(index);
        let foundIndex = currentModalSegmentsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalSegmentsIndexes.splice(foundIndex, 1);
        updateSegmentTables();
        closeModal(0);
      });
  
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(segment_data[1]);
    newRow.append(newLabel);

    modalSegmentsData.push(newRow);
    currentModalSegmentsIndexes.push(index);
  });

  segments_data.forEach((segment_data, index) => {  // filling segmentsData with html  
    const newRow = $('<div></div>')
      .addClass(`custom-table__table-row-wrapper table-row-wrapper`)
      .attr('id', `row_${index}_table_0`);

    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(segment_data[1]);

    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        console.log('Segment delete clicked!');
        let foundIndex = currentSegmentsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentSegmentsIndexes.splice(foundIndex, 1);
        currentModalSegmentsIndexes.push(index);
        updateSegmentTables();
    });
    
    newRow.append(newLabel, newDeleteButton);
    segmentsData.push(newRow);
  });

  segments_data.forEach((segment_data, index) => {  // filling hiddenSegmentsData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `segment_${segment_data[0]}`)
      .attr('name', 'segments_ids[]')
      .attr('type', 'hidden')
      .val(segment_data[0]);

    hiddenSegmentsData.push(newHiddenInputSegment);
  });

  updateSegmentTables();
});

function updateSegmentTables() {
  if (addSegmentButton == null)
    addSegmentButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#current-segments-ids').empty();

  currentSegmentsIndexes.forEach((index) => {
    $('#listing-table_0').append(segmentsData[index]);
    $('#current-segments-ids').append(hiddenSegmentsData[index]);
  });
  if(currentSegmentsIndexes.length < segmentsData.length)
    $('#listing-table_0').append(addSegmentButton);
  
  currentModalSegmentsIndexes.forEach((index) => {
    $('#listing-table_1').append(modalSegmentsData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}