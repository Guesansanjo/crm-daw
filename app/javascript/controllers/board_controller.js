import { Controller } from "@hotwired/stimulus";
import axios from "axios";
import { get, map, isNull } from "lodash-es";

export default class extends Controller {
  HEADERS = { ACCEPT: "application/json" };

  connect() {
    axios
      .get("/api/boards/1/lists", { headers: this.HEADERS })
      .then((response) => {
        this.buildKanban(this.buildBoards(response["data"]));
      });
  }

  buildClassList(classList) {
    if (isNull(classList)) {
      return "";
    }
    return classList.split(" ").join(", ");
  }

  buildItems(items) {
    return map(items, (item) => {
      return {
        id: get(item, "id"),
        title: get(item, "attributes.title"),
        class: this.buildClassList(get(item, "attributes.class_list")),
      };
    });
  }

  buildBoards(boardsData) {
    return map(boardsData["data"], (board) => {
      return {
        id: get(board, "id"),
        title: get(board, "attributes.title"),
        class: this.buildClassList(get(board, "attributes.class_list")),
        item: this.buildItems(get(board, "attributes.items.data")),
      };
    });
  }

  buildKanban(boards) {
    new jKanban({
      element: "#board", // selector of the kanban container
      boards: boards, // json of boards
      itemAddOptions: {
        enabled: true, // add a button to board for easy item creation                                     // position the button on footer
      },
    });
  }
}
