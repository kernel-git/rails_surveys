//const { $ } = require('@rails/ujs');

let modalSegmentsData = [];
let currentModalSegmentsIndexes = [];
let segmentsData = [];
let hiddenSegmentsData = [];
let currentSegmentsIndexes = [];
let addSegmentButton = null;

let clientsData = [];
let hiddenClientsData = [];
let currentClientIndex = null;
let addClientButton = null;


$(document).ready(() => {
  $('#add-row_1').on('click', () => {
    openModal(1);
  });
  $('#modal-close_1').on('click', () => {
    closeModal(1);
  });

  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let segments_data = $('#segments_data').data('segments');
  let clients_data = $('#clients_data').data('clients');

  segments_data.forEach((segment_data, index) => {  // filling modalSegmentsData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`)
      .on('click', () => {
        console.log(`Modal segment clicked with index: ${index}`);
        currentSegmentsIndexes.push(index);
        let foundIndex = currentModalSegmentsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalSegmentsIndexes.splice(foundIndex, 1);
        updateSegmentTables();
        closeModal(1);
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
      .attr('id', `row_${index}_table_1`);

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

  clients_data.forEach((client_data, index) => {  // adding html to client modal
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_2`)
      .on('click', () => {
        console.log('Client modal clicked!')
        currentClientIndex = index;
        updateClientTables();
        closeModal(0);
      });
    const newLogoWrapper = $('<div></div>')
      .addClass('table-row-wrapper__information')
    const newLogo = $('<img>')
      .attr('src', client_data[1])
      .attr('width', '75')
      .attr('height', '75');

    newLogoWrapper.append(newLogo);
    
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(client_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(client_data[3]);

    newRow.append(newLogoWrapper, newLabel, newEmail);
    $(`#listing-table_2`).append(newRow);
  });

  clients_data.forEach((client_data, index) => {  // filling clientsData with html  
    const newRow = $('<div></div>')
      .addClass(`custom-table__table-row-wrapper table-row-wrapper`)
      .attr('id', `row_${index}_table_0`);
    const newLogoWrapper = $('<div></div>')
      .addClass('table-row-wrapper__information')
    const newLogo = $('<img>')
      .attr('src', client_data[1])
      .attr('width', '75')
      .attr('height', '75');

    newLogoWrapper.append(newLogo);
    
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(client_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(client_data[3]);

    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        console.log('Client delete clicked!');
        currentClientIndex = null;
        updateClientTables();
      });

    newRow.append(newLogoWrapper, newLabel, newEmail, newDeleteButton);
    clientsData.push(newRow)
  });

  clients_data.forEach((client_data, index) => {  // filling hiddenClientsData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `client_${client_data[0]}`)
      .attr('name', 'client_id')
      .attr('type', 'hidden')
      .val(client_data[0]);

    hiddenClientsData.push($('#current_client_id').append(newHiddenInputSegment));
  });

  updateClientTables();
});

function updateSegmentTables() {
  if (addSegmentButton == null)
    addSegmentButton = $('#add-row_1').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#listing-table_3 .table-row-wrapper').detach();
  $('#current-segments-ids').empty();

  currentSegmentsIndexes.forEach((index) => {
    $('#listing-table_1').append(segmentsData[index]);
    $('#current-segments-ids').append(hiddenSegmentsData[index]);
  });
  if(currentSegmentsIndexes.length < segmentsData.length)
    $('#listing-table_1').append(addSegmentButton);
  
  currentModalSegmentsIndexes.forEach((index) => {
    $('#listing-table_3').append(modalSegmentsData[index]);
  });
}

function updateClientTables() {
  if (addClientButton == null)
    addClientButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#current-client-id').empty();

  $('#listing-table_0').append(clientsData[currentClientIndex]);
  if (currentClientIndex == null)
    $('#listing-table_0').append(addClientButton);

  $('#current-client-id').append(hiddenClientsData[currentClientIndex]);
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}