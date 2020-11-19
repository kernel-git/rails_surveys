//const { $ } = require('@rails/ujs');

let currentUsers = [];
let currentClients = [];

$(document).ready(() => {
  let users_data = $('#users_data').data('users');
  let clients_data = $('#clients_data').data('clients');

  users_data.forEach(addOptionToUserSelect);
  clients_data.forEach(addOptionToClientSelect);

  $('#add_selected_user').click(() => {
    const selectedValue = $('#new_user_select').val();
    const selectedText = $('#new_user_select option:selected').text();

    currentUsers.push([selectedValue, selectedText]);

    const newUserWrapper = $('<div></div>').attr('id', `user_${selectedValue}_wrapper`);
    const newUserLabel = $('<h4></h4>').text(selectedText);
    const newUserDelete = $('<button></button>')
      .attr('id', `user_${selectedValue}_delete`)
      .text('Delete');
    newUserWrapper.append(newUserLabel, newUserDelete);
    $('#current_users_wrapper').append(newUserWrapper);

    const newHiddenInputUser = $('<input></input>')
      .attr('id', `user_${selectedValue}`)
      .attr('name', 'segment[users_ids][]')
      .attr('type', 'hidden')
      .val(selectedValue);
    $('#current_users_ids').append(newHiddenInputUser);

    $('#new_user_select option:selected').remove();

    $(`#user_${selectedValue}_delete`).on('click', function(){
      const deleteId = $(this).parent().attr('id').split('_')[1];
      const deleteUserData = currentUsers.find((elem) => elem[0] == deleteId);
      currentUsers.splice(currentUsers.indexOf(deleteUserData), 1);
      addOptionToUserSelect(deleteUserData);
      $(`#user_${deleteUserData[0]}_wrapper`).remove();
      $(`#user_${deleteUserData[0]}`).remove();
    })
  });

  $('#add_selected_client').click(() => {
    const selectedValue = $('#new_client_select').val();
    const selectedText = $('#new_client_select option:selected').text();

    currentClients.push([selectedValue, selectedText]);

    const newClientWrapper = $('<div></div>').attr('id', `client_${selectedValue}_wrapper`);
    const newClientLabel = $('<h4></h4>').text(selectedText);
    const newClientDelete = $('<button></button>')
      .attr('id', `client_${selectedValue}_delete`)
      .text('Delete');
    newClientWrapper.append(newClientLabel, newClientDelete);
    $('#current_clients_wrapper').append(newClientWrapper);

    const newHiddenInputClient = $('<input></input>')
      .attr('id', `client_${selectedValue}`)
      .attr('name', 'segment[clients_ids][]')
      .attr('type', 'hidden')
      .val(selectedValue);
    $('#current_clients_ids').append(newHiddenInputClient);

    $('#new_client_select option:selected').remove();

    $(`#client_${selectedValue}_delete`).on('click', function(){
      const deleteId = $(this).parent().attr('id').split('_')[1];
      const deleteClientData = currentClients.find((elem) => elem[0] == deleteId);
      currentClients.splice(currentClients.indexOf(deleteClientData), 1);
      addOptionToClientSelect(deleteClientData);
      $(`#client_${deleteClientData[0]}_wrapper`).remove();
      $(`#client_${deleteClientData[0]}`).remove();
    })
  });
});

function addOptionToClientSelect(value){
  const newOption = $('<option></option>')
    .attr('value', value[0])
    .text(value[1]);
  $('#new_client_select').append(newOption);
}

function addOptionToUserSelect(value){
  const newOption = $('<option></option>')
    .attr('value', value[0])
    .text(value[1]);
  $('#new_user_select').append(newOption);
}

