$(document).ready(() => {

  $("div[id^='sort-arrow']").each((i, el) => {
    $(`#${el.id}`).on('click', function(){
      let sortType = el.id.split('_')[1];
      let sortFieldId = el.id.split('_')[2];
      let sortTableId = el.id.split('_')[4];

      let tableRows = $(`.table-row_${sortTableId}`)

      tableRows.sort((a, b) => {
        let aFieldValue = a.children[sortFieldId].innerText;
        let bFieldValue = b.children[sortFieldId].innerText;

        if (sortType == 'up') {
          if (aFieldValue > bFieldValue)
            return 1;
          else if (aFieldValue < bFieldValue)
            return -1;
          else if (aFieldValue === bFieldValue)
            return 0;
        }
        else if (sortType == 'down') {
          if (aFieldValue < bFieldValue)
            return 1;
          else if (aFieldValue > bFieldValue)
            return -1;
          else if (aFieldValue === bFieldValue)
            return 0;
        }
        return 0;
      });

      $(`.table-row_${sortTableId}`).remove();
      tableRows.each((index, elem) => {
        $(`#listing-table_${sortTableId}`).append(elem);
      });
      
    });
  });
  
  
});

