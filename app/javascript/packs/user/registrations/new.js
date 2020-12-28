//const { $ } = require('@rails/ujs');

let clientsData = [];
let hiddenClientsData = [];
let currentClientIndex = null;
let addClientButton = null;


$(document).ready(() => {
  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let clients_data = $('#clients_data').data('clients');

  clients_data.forEach((client_data, index) => {  // adding html to client modal
    console.log(client_data);
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_1`)
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
    $(`#listing-table_1`).append(newRow);
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