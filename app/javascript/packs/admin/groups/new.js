//const { $ } = require('@rails/ujs');

let modalEmployeesData = [];
let currentModalEmployeesIndexes = [];
let employeesData = [];
let hiddenEmployeesData = [];
let currentEmployeesIndexes = [];
let addEmployeeButton = null;

$(document).ready(() => {

  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let employees_data = $('#employees_data').data('employees');

  employees_data.forEach((employee_data, index) => {  // filling modalEmployeesData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_2`)
      .on('click', () => {
        currentEmployeesIndexes.push(index);
        let foundIndex = currentModalEmployeesIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalEmployeesIndexes.splice(foundIndex, 1);
        updateEmployeeTables();
        closeModal(0);
      });
  
    const newFirstName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[1]);
    const newLastName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[3]);
    const newEmployerLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[4]);
    newRow.append(newFirstName, newLastName, newEmail, newEmployerLabel);

    modalEmployeesData.push(newRow);
    currentModalEmployeesIndexes.push(index);
  });

  employees_data.forEach((employee_data, index) => {  // filling employeesData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`);
  
    const newFirstName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[1]);
    const newLastName = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[2]);
    const newEmail = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[3]);
    const newEmployerLabel = $('<div></div>')
      .addClass("table-row-wrapper__information")
      .text(employee_data[4]);
    const newDeleteButton = $('<div></div>')
      .addClass('table-row-wrapper__information link-button')
      .text('Delete')
      .on('click', () => {
        let foundIndex = currentEmployeesIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentEmployeesIndexes.splice(foundIndex, 1);
        currentModalEmployeesIndexes.push(index);
        updateEmployeeTables();
    });
    newRow.append(newFirstName, newLastName, newEmail, newEmployerLabel, newDeleteButton);

    employeesData.push(newRow);
  });

  employees_data.forEach((employee_data, index) => {  // filling hiddenEmployeesData with html  
    const newHiddenInputGroup = $('<input></input>')
      .attr('id', `employee_${employee_data[0]}`)
      .attr('name', 'group[employee_ids][]')
      .attr('type', 'hidden')
      .val(employee_data[0]);

    hiddenEmployeesData.push(newHiddenInputGroup);
  });

  updateEmployeeTables();
});

function updateEmployeeTables() {
  if (addEmployeeButton == null)
    addEmployeeButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#listing-table_2 .table-row-wrapper').detach();
  $('#current-employee-ids').empty();

  currentEmployeesIndexes.forEach((index) => {
    $('#listing-table_0').append(employeesData[index]);
    $('#current-employee-ids').append(hiddenEmployeesData[index]);
  });
  if(currentEmployeesIndexes.length < employeesData.length)
    $('#listing-table_0').append(addEmployeeButton);
  
  currentModalEmployeesIndexes.forEach((index) => {
    $('#listing-table_2').append(modalEmployeesData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}