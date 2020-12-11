let modalUsersData = [];
let currentModalUsersIndexes = [];
let usersData = [];
let hiddenUsersData = [];
let currentUsersIndexes = [];
let addUserButton = null;

$(document).ready(() => {

  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let users_data = $('#users_data').data('users');

  let init_users_ids = $('#current_assigned_users_ids').data('assigned-users');
  if (init_users_ids == undefined)
    init_users_ids = [];

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
    if(!init_users_ids.includes(user_data[0]))
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
    if(init_users_ids.includes(user_data[0]))
      currentUsersIndexes.push(index);
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
});

function updateUserTables() {
  if (addUserButton == null)
    addUserButton = $('#add-row_0').detach();
  $('#listing-table_0').children('.table-row-wrapper').detach();
  $('#listing-table_1').children('.table-row-wrapper').detach();
  $('#current-users-ids').empty();

  currentUsersIndexes.forEach((index) => {
    $('#listing-table_0').append(usersData[index]);
    $('#current-users-ids').append(hiddenUsersData[index]);
  });
  if(currentUsersIndexes.length < usersData.length)
    $('#listing-table_0').append(addUserButton);
  
  currentModalUsersIndexes.forEach((index) => {
    $('#listing-table_1').append(modalUsersData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}