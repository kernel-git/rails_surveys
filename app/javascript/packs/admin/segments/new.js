//const { $ } = require('@rails/ujs');

let modalUsersData = [];
let currentModalUsersIndexes = [];
let usersData = [];
let hiddenUsersData = [];
let currentUsersIndexes = [];
let addUserButton = null;

let modalClientsData = [];
let currentModalClientsIndexes = [];
let clientsData = [];
let hiddenClientsData = [];
let currentClientsIndexes = [];
let addClientButton = null;


$(document).ready(() => {

  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  $('#add-row_1').on('click', () => {
    openModal(1);
  });
  $('#modal-close_1').on('click', () => {
    closeModal(1);
  });

  let users_data = $('#users_data').data('users');
  let clients_data = $('#clients_data').data('clients');

  users_data.forEach((user_data, index) => {  // filling modalUsersData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_2`)
      .on('click', () => {
        currentUsersIndexes.push(index);
        let foundIndex = currentModalUsersIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalUsersIndexes.splice(foundIndex, 1);
        updateUserTables();
        closeModal(0);
      });
  
    const newFirstName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[1]);
    const newLastName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[3]);
    const newCompanyLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[4]);
    newRow.append(newFirstName, newLastName, newEmail, newCompanyLabel);

    modalUsersData.push(newRow);
    currentModalUsersIndexes.push(index);
  });

  users_data.forEach((user_data, index) => {  // filling usersData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`);
  
    const newFirstName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[1]);
    const newLastName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[3]);
    const newCompanyLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(user_data[4]);
    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        let foundIndex = currentUsersIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentUsersIndexes.splice(foundIndex, 1);
        currentModalUsersIndexes.push(index);
        updateUserTables();
    });
    newRow.append(newFirstName, newLastName, newEmail, newCompanyLabel, newDeleteButton);

    usersData.push(newRow);
  });

  users_data.forEach((user_data, index) => {  // filling hiddenUsersData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `user_${user_data[0]}`)
      .attr('name', 'users_ids[]')
      .attr('type', 'hidden')
      .val(user_data[0]);

    hiddenUsersData.push(newHiddenInputSegment);
  });

  updateUserTables();

  clients_data.forEach((client_data, index) => {  // filling modalClientData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`)
      .on('click', () => {
        currentClientsIndexes.push(index);
        let foundIndex = currentModalClientsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalClientsIndexes.splice(foundIndex, 1);
        updateClientTables();
        closeModal(1);
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

    modalClientsData.push(newRow);
    currentModalClientsIndexes.push(index);
  });

  clients_data.forEach((client_data, index) => {  // filling clientsData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`);
  
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
        let foundIndex = currentClientsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentClientsIndexes.splice(foundIndex, 1);
        currentModalClientsIndexes.push(index);
        updateClientTables();
    });
    newRow.append(newLogoWrapper, newLabel, newEmail, newDeleteButton);

    clientsData.push(newRow);
  });

  clients_data.forEach((client_data, index) => {  // filling hiddenClientData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `client_${client_data[0]}`)
      .attr('name', 'clients_ids[]')
      .attr('type', 'hidden')
      .val(client_data[0]);

    hiddenClientsData.push(newHiddenInputSegment);
  });

  updateClientTables();
  
});

function updateUserTables() {
  if (addUserButton == null)
    addUserButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#listing-table_2 .table-row-wrapper').detach();
  $('#current-user-ids').empty();

  currentUsersIndexes.forEach((index) => {
    $('#listing-table_0').append(usersData[index]);
    $('#current-user-ids').append(hiddenUsersData[index]);
  });
  if(currentUsersIndexes.length < usersData.length)
    $('#listing-table_0').append(addUserButton);
  
  currentModalUsersIndexes.forEach((index) => {
    $('#listing-table_2').append(modalUsersData[index]);
  });
}

function updateClientTables() {
  if (addClientButton == null)
    addClientButton = $('#add-row_1').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#listing-table_3 .table-row-wrapper').detach();
  $('#current-client-ids').empty();

  currentClientsIndexes.forEach((index) => {
    $('#listing-table_1').append(clientsData[index]);
    $('#current-client-ids').append(hiddenClientsData[index]);
  });
  if(currentClientsIndexes.length < clientsData.length)
    $('#listing-table_1').append(addClientButton);
  
  currentModalClientsIndexes.forEach((index) => {
    $('#listing-table_3').append(modalClientsData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}