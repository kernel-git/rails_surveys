//const { $ } = require('@rails/ujs');

let modalGroupsData = [];
let currentModalGroupsIndexes = [];
let groupsData = [];
let hiddenGroupsData = [];
let currentGroupsIndexes = [];
let addGroupButton = null;

let employersData = [];
let hiddenEmployersData = [];
let currentEmployerIndex = null;
let addEmployerButton = null;


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

  let groups_data = $('#groups_data').data('groups');
  let employers_data = $('#employers_data').data('employers');

  groups_data.forEach((group_data, index) => {  // filling modalGroupsData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`)
      .on('click', () => {
        console.log(`Modal group clicked with index: ${index}`);
        currentGroupsIndexes.push(index);
        let foundIndex = currentModalGroupsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalGroupsIndexes.splice(foundIndex, 1);
        updateGroupTables();
        closeModal(1);
      });
  
    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(group_data[1]);
    newRow.append(newLabel);

    modalGroupsData.push(newRow);
    currentModalGroupsIndexes.push(index);
  });

  groups_data.forEach((group_data, index) => {  // filling groupsData with html  
    const newRow = $('<div></div>')
      .addClass(`custom-table__table-row-wrapper table-row-wrapper`)
      .attr('id', `row_${index}_table_1`);

    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(group_data[1]);

    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        console.log('Group delete clicked!');
        let foundIndex = currentGroupsIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentGroupsIndexes.splice(foundIndex, 1);
        currentModalGroupsIndexes.push(index);
        updateGroupTables();
    });
    
    newRow.append(newLabel, newDeleteButton);
    groupsData.push(newRow);
  });

  groups_data.forEach((group_data, index) => {  // filling hiddenGroupsData with html  
    const newHiddenInputGroup = $('<input></input>')
      .attr('id', `group_${group_data[0]}`)
      .attr('name', 'employee[group_ids][]')
      .attr('type', 'hidden')
      .val(group_data[0]);

    hiddenGroupsData.push(newHiddenInputGroup);
  });

  updateGroupTables();

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
    $(`#listing-table_2`).append(newRow);
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
    const newHiddenInputGroup = $('<input></input>')
      .attr('id', `employer_${employer_data[0]}`)
      .attr('name', 'employee[employer_id]')
      .attr('type', 'hidden')
      .val(employer_data[0]);

    hiddenEmployersData.push(newHiddenInputGroup);
  });

  updateEmployerTables();
});

function updateGroupTables() {
  if (addGroupButton == null)
    addGroupButton = $('#add-row_1').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#listing-table_3 .table-row-wrapper').detach();
  $('#current-groups-ids').empty();

  currentGroupsIndexes.forEach((index) => {
    $('#listing-table_1').append(groupsData[index]);
    $('#current-groups-ids').append(hiddenGroupsData[index]);
  });
  if(currentGroupsIndexes.length < groupsData.length)
    $('#listing-table_1').append(addGroupButton);
  
  currentModalGroupsIndexes.forEach((index) => {
    $('#listing-table_3').append(modalGroupsData[index]);
  });
}

function updateEmployerTables() {
  if (addEmployerButton == null)
    addEmployerButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#current_employer_id').empty();

  $('#listing-table_0').append(employersData[currentEmployerIndex]);
  if (currentEmployerIndex == null)
    $('#listing-table_0').append(addEmployerButton);

  $('#current_employer_id').append(hiddenEmployersData[currentEmployerIndex]);
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}