//const { $ } = require('@rails/ujs');

let modalGroupsData = [];
let currentModalGroupsIndexes = [];
let groupsData = [];
let hiddenGroupsData = [];
let currentGroupsIndexes = [];
let addGroupButton = null;
let initGroupsIds = [];

$(document).ready(() => {
  $('#add-row_1').on('click', () => {
    openModal(1);
  });
  $('#modal-close_1').on('click', () => {
    closeModal(1);
  });

  let groups_data = $('#groups_data').data('groups');
  initGroupsIds = $('#init_groups_ids').data('ids');

  groups_data.forEach((group_data, index) => {  // filling groupsData with html  
    const newRow = $('<div></div>')
      .addClass(`custom-table__table-row-wrapper table-row-wrapper`)
      .attr('id', `row_${index}_table_1`);

    const newLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(group_data[1]);
    
    const newDate = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(group_data[2]);

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
    
    newRow.append(newLabel, newDate, newDeleteButton);
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
    const newDate = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(group_data[2]);
    newRow.append(newLabel, newDate);

    modalGroupsData.push(newRow);
    currentModalGroupsIndexes.push(index);
    if (initGroupsIds.includes(group_data[0])) {
      currentGroupsIndexes.push(index);
      let foundIndex = currentModalGroupsIndexes.findIndex((elem) => {
        return elem == index;
      });
      currentModalGroupsIndexes.splice(foundIndex, 1);
      updateGroupTables();
    }
  });

  updateGroupTables();
});

function updateGroupTables() {
  if (addGroupButton == null)
    addGroupButton = $('#add-row_1').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#listing-table_3 .table-row-wrapper').detach();
  $('#current_groups_ids').empty();

  currentGroupsIndexes.forEach((index) => {
    $('#listing-table_1').append(groupsData[index]);
    $('#current_groups_ids').append(hiddenGroupsData[index]);
  });
  if(currentGroupsIndexes.length < groupsData.length)
    $('#listing-table_1').append(addGroupButton);
  
  currentModalGroupsIndexes.forEach((index) => {
    $('#listing-table_3').append(modalGroupsData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}