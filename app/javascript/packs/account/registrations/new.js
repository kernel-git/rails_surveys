//const { $ } = require('@rails/ujs');

let employersData = [];
let hiddenEmployersData = [];
let currentEmployerIndex = null;
let addEmployerButton = null;


$(document).ready(() => {
  $('#add-row_0').on('click', () => {
    openModal(0);
  });
  $('#modal-close_0').on('click', () => {
    closeModal(0);
  });

  let employers_data = $('#employers_data').data('employers');

  employers_data.forEach((employer_data, index) => {  // adding html to employer modal
    console.log(employer_data);
    const newRow = $('<div></div>')
      .addClass('custom-table__table-row-wrapper table-row-wrapper link-div')
      .attr('id', `row_${index}_table_1`)
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
    $(`#listing-table_1`).append(newRow);
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
    const newHiddenInputSegment = $('<input></input>')
      .attr('id', `employer_${employer_data[0]}`)
      .attr('name', 'employee[employer_id]')
      .attr('type', 'hidden')
      .val(employer_data[0]);

    hiddenEmployersData.push(newHiddenInputSegment);
  });

  updateEmployerTables();
});

function updateEmployerTables() {
  if (addEmployerButton == null)
    addEmployerButton = $('#add-row_0').detach();
  $('#listing-table_0 .table-row-wrapper').detach();
  $('#current-employer-id').empty();

  $('#listing-table_0').append(employersData[currentEmployerIndex]);
  if (currentEmployerIndex == null)
    $('#listing-table_0').append(addEmployerButton);

  $('#current-employer-id').append(hiddenEmployersData[currentEmployerIndex]);
}

function openModal(modalId) {
  $(`#modal_${modalId}`).removeClass('modal-background--hidden');
}

function closeModal(modalId) {
  $(`#modal_${modalId}`).addClass('modal-background--hidden');
}