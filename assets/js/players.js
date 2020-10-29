import $ from "jquery";

var playerName = "";
var pageNumber = 1;
var sortBy = "yds";
var desc = true;

let htmlPlayer = function(p) {
  return `
    <tr class="player">
      <td>${p.name}</td>
      <td>${p.team}</td>
      <td>${p.pos}</td>
      <td>${p.att}</td>
      <td>${p.attG}</td>
      <td>${p.yds}</td>
      <td>${p.avg}</td>
      <td>${p.ydsG}</td>
      <td>${p.td}</td>
      <td>${p.lng}${p.lngT ? "T" : ""}</td>
      <td>${p.first}</td>
      <td>${p.firstPercentage}%</td>
      <td>${p.twentyPlus}</td>
      <td>${p.fourtyPlus}</td>
      <td>${p.fum}</td>
  </tr>`;
}

let htmlPlayers = function(players) {
  var rows = "";
  $.each(players, function( index, player ) {
    rows += htmlPlayer(player);
  });
  return rows;
}

let htmlPagination = function(result) {
  var pagination = require('pagination')
  var boostrapPaginator = new pagination.TemplatePaginator({
    current: result.pageNumber, rowsPerPage: result.pageSize,
    totalResult: result.totalEntries, slashSeparator: true,
    template: function(result) {
        var i, len, prelink;
        var html = '<div><ul class="pagination">';
        if(result.pageCount < 2) { 
            html += '</ul></div>';
            return html;
        }

        if(result.first) {
          html += '<li class="page-item"><a class="page-link btn" name="' + result.first + '">|&lt;</a></li>';
        }
        if(result.previous) {
            html += '<li class="page-item"><a class="page-link btn" name="' + result.previous + '">&lt;</a></li>';
        }
        if(result.range.length) {
            for( i = 0, len = result.range.length; i < len; i++) {
                if(result.range[i] === result.current) {
                    html += '<li class="active page-item"><a class="page-link btn" name="' + result.range[i] + '">' + result.range[i] + '</a></li>';
                } else {
                    html += '<li class="page-item"><a class="page-link btn" name="' + result.range[i] + '">' + result.range[i] + '</a></li>';
                }
            }
        }
        if(result.next) {
            html += '<li class="page-item"><a class="page-link btn paginator-next" id="link_page_next" name="' + result.next + '">&gt;</a></li>';
        }
        if(result.last) {
          html += '<li class="page-item"><a class="page-link btn" name="' + result.last + '">&gt;|</a></li>';
        }
        html += '</ul></div>';
        return html;
    }
  });
  return boostrapPaginator.render();
}

let reloadPlayers = function(result) {
  $("#div_total_entries").html(result.totalEntries)
  $("#div_total_pages").html(result.totalPages)
  $("#tbody_players").html(htmlPlayers(result.entries))
  $("#paginator").html(htmlPagination(result));
  $(".page-link").on("click", function() {goToPage(this.name)});
};

let generateQuery = function() {
  return `{players(
    playerName: "${playerName}"
    page: ${pageNumber}
    sortBy: "${sortBy}"
    desc: ${desc}
    ) {
    pageSize
    pageNumber
    totalEntries
    totalPages
    entries {
      id
      name
      team
      pos
      att
      attG
      yds
      ydsG
      td
      avg
      lng
      lngT
      first
      firstPercentage
      twentyPlus
      fourtyPlus
      fum
    }
  }}`;
}

let runQuery = function(query) {
  $.ajax({url: "http://127.0.0.1:4000/graphql",
    type:'POST',
    contentType: "application/json",
    data: JSON.stringify({ "query": query }),
    success: function(response) {
      reloadPlayers(response.data.players);
    }
  });
}

let loadPlayers = function() {
  var query = generateQuery();
  runQuery(query);
}

let searchByName = function() {
  playerName = this.value
  loadPlayers();
};

let sortByField = function(field) {
  if (sortBy == field) {
    desc = !desc;
  } else {
    sortBy = field;
  }
  loadPlayers();
}

let goToPage = function(page) {
  pageNumber = page;
  loadPlayers();
}

let resetFilter = function() {
  $("#txt_player_name").val(""); 
  playerName = "";
  loadPlayers();
}

$("#btn_reset").on("click", resetFilter);
$("#txt_player_name").on("keyup", searchByName);
$("#link_sort_by_yards").on("click", function() {sortByField("yds");});
$("#link_sort_by_longest").on("click", function() {sortByField("lng");});
$("#link_sort_by_touchdowns").on("click", function() {sortByField("td");});

loadPlayers();
