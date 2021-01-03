//const { $ } = require('@rails/ujs');

let modalEmployeesData = [];
let currentModalEmployeesIndexes = [];
let employeesData = [];
let hiddenEmployeesData = [];
let currentEmployeesIndexes = [];
let addEmployeeButton = null;

let modalEmployersData = [];
let currentModalEmployersIndexes = [];
let employersData = [];
let hiddenEmployersData = [];
let currentEmployersIndexes = [];
let addEmployerButton = null;


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

  let employees_data = $('#employees_data').data('employees');
  let employers_data = $('#employers_data').data('employers');

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
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `employee_${employee_data[0]}`)
      .attr('name', 'employees_ids[]')
      .attr('type', 'hidden')
      .val(employee_data[0]);

    hiddenEmployeesData.push(newHiddenInputSegment);
  });

  updateEmployeeTables();

  employers_data.forEach((employer_data, index) => {  // filling modalEmployerData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`)
      .on('click', () => {
        currentEmployersIndexes.push(index);
        let foundIndex = currentModalEmployersIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentModalEmployersIndexes.splice(foundIndex, 1);
        updateEmployerTables();
        closeModal(1);
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

    modalEmployersData.push(newRow);
    currentModalEmployersIndexes.push(index);
  });

  employers_data.forEach((employer_data, index) => {  // filling employersData with html
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_3`);
  
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
        let foundIndex = currentEmployersIndexes.findIndex((elem) => {
          return elem == index;
        });
        currentEmployersIndexes.splice(foundIndex, 1);
        currentModalEmployersIndexes.push(index);
        updateEmployerTables();
    });
    newRow.append(newLogoWrapper, newLabel, newEmail, newDeleteButton);

    employersData.push(newRow);
  });

  employers_data.forEach((employer_data, index) => {  // filling hiddenEmployerData with html  
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `employer_${employer_data[0]}`)
      .attr('name', 'employers_ids[]')
      .attr('type', 'hidden')
      .val(employer_data[0]);

    hiddenEmployersData.push(newHiddenInputSegment);
  });

  updateEmployerTables();
  
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

function updateEmployerTables() {
  if (addEmployerButton == null)
    addEmployerButton = $('#add-row_1').detach();
  $('#listing-table_1 .table-row-wrapper').detach();
  $('#listing-table_3 .table-row-wrapper').detach();
  $('#current-employer-ids').empty();

  currentEmployersIndexes.forEach((index) => {
    $('#listing-table_1').append(employersData[index]);
    $('#current-employer-ids').append(hiddenEmployersData[index]);
  });
  if(currentEmployersIndexes.length < employersData.length)
    $('#listing-table_1').append(addEmployerButton);
  
  currentModalEmployersIndexes.forEach((index) => {
    $('#listing-table_3').append(modalEmployersData[index]);
  });
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}