import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";
import axios from "axios";
import { get, map , sample } from "lodash-es";

export default class extends Controller {
  HEADERS = { ACCEPT: "application/json" };
  BACKGROUND_COLORS = ['bg-info', 'bg-primary', 'bg-secondary', 'bg-success', 'bg-warning', 'bg-danger', 'bg-dark'];

  getHeaderTitles(){
    return Array.from(document.getElementsByClassName('kanban-title-board'));
  }

  getHeaders() {
    return Array.from(document.getElementsByClassName('kanban-board-header'));
  }

  cursorifyHeaderTitle(){
    this.getHeaderTitles().forEach((headerTitle) => {
      headerTitle.classList.add('cursor-pointer');
    });
  }


  buildBoardDeleteButton(boardId){
    const button = document.createElement('button');
    button.classList.add('kanban-title-button');
    button.classList.add('btn');
    button.classList.add('btn-default');
    button.classList.add('btn-xs');
    button.classList.add('mr-2');
    button.textContent = 'x';
    button.addEventListener('click', (e) =>{
      e.preventDefault();
      console.log('button clcicked with boardId: ' + boardId);

      axios.delete(`${this.element.dataset.boardListsUrl}/${boardId}` , {
        headers: this.HEADERS
      }).then((_) => { 
          Turbo.visit(window.location.href);
      });  

    });
    return button;
  };

  addHeaderDeleteButtons(boards) {
    this.getHeaders().forEach((header,index) => { 
      header.appendChild(this.buildBoardDeleteButton(boards[index].id));
    });
  }

  addLinkToHeaderTitle(boards){
    this.getHeaderTitles().forEach((headerTitle,index) => {
      headerTitle.addEventListener('click' ,() => {
        Turbo.visit(`${this.element.dataset.boardListsUrl}/${boards[index].id}/edit`);
      });
  
    });
  }

  connect() {
    axios.get(this.element.dataset.apiUrl, { headers: this.HEADERS })
      .then((response) => {
        this.buildKanban(this.buildBoards(response['data']));   
        this.cursorifyHeaderTitle();
        this.addLinkToHeaderTitle(this.buildBoards(response['data']));
        this.addHeaderDeleteButtons(this.buildBoards(response['data']));
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
      click: () => {
        console.log('board clicked')
      },
      dragendBoard:  (el)=> {
        axios.put(`${this.element.dataset.apiUrl}/${el.dataset.id}`, {
          position: el.dataset.order - 1
        },{
          headers: this.HEADERS
        }).then((response) => {
          console.log('response: ', response);
      });
    },
    });
  }
}
