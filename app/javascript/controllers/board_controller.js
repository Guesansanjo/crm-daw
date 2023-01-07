import { Controller } from "@hotwired/stimulus";
import axios from "axios";
import { get, map , sample } from "lodash-es";

export default class extends Controller {
  HEADERS = { ACCEPT: "application/json" };
  BACKGROUND_COLORS = ['bg-info', 'bg-primary', 'bg-secondary', 'bg-success', 'bg-warning', 'bg-danger', 'bg-dark'];

  connect() {
    axios.get(this.element.dataset.apiUrl, { headers: this.HEADERS })
      .then((response) => {
        this.buildKanban(this.buildBoards(response['data']));   
      });
  }


  buildClassList(){
    return `text-white, ${sample(this.BACKGROUND_COLORS)}`;
  }


  buildItems(items) {
    return map(items, (item) => {
      return {
        'id': get(item, 'id'),
        'title': get(item, 'attributes.title'),
      };
    });
  }

  buildBoards(boardsData) {
    return map(boardsData['data'], (board) => {
      return {
        'id': get(board, 'id'),
        'title': get(board, 'attributes.title'),
        'class': this.buildClassList(),
        'item': this.buildItems(get(board, 'attributes.items.data')),
      };
    });
  }

  buildKanban(boards) {
    new jKanban({
      element: `#${this.element.id}`, // selector of the kanban container
      boards: boards, // json of boards
      itemAddOptions: {
        enabled: true, // add a button to board for easy item creation                                     // position the button on footer
      },
    });
  }
}
