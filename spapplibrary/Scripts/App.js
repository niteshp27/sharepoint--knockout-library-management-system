/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="knockout-3.1.0.debug.js" />
//'use strict';

var appContext = SP.ClientContext.get_current();
//var user = appContext.get_web().get_currentUser();
//var currUrl = appContext.get_url();

var jQ = $.noConflict();//,


var logger = (function (_window, undefined) {

    function _log(msg) {

        _window.console.log(msg);
    };

    return {
        log: _log
    };

})(window);

var userModule = (function (jQ, trace, context) {


    var userService = function () {

        // This function prepares, loads, and then executes a SharePoint query to get the current users information
        function _printUserName() {

            var user = context.get_web().get_currentUser();

            trace.log("get user");
            context.load(user);
            context.executeQueryAsync(onGetUserNameSuccess, onGetUserNameFail);

            function onGetUserNameSuccess() {
                jQ('#helloBlock').text('Hello ' + user.get_title());
                trace.log("user success");
            };

            // This function is executed if the above call fails
            function onGetUserNameFail(sender, args) {
                trace.log('user Failed to get user name. Error:' + args.get_message());
            };
        };

        return {
            PrintCurrentUser: _printUserName
        };
    };

    return new userService();

})(jQ, logger, appContext);


function issueBook() {
    
    var currUrl = appContext.get_url();
    var _cururl = 'https://' + window.location.host + currUrl;
    _cururl += '/Lists/LibraryBookLists/NewForm.aspx?RootFolder=';
    SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Issue Book', allowMaximize: true, showClose: true });
    logger.log("url");
    return false;
};

//bookissuedto function/model


function book(data) {
    var self = this;
    self.bookTitle = ko.observable(data.bookTitle);
    self.bookAuthor = ko.observable(data.bookAuthor);
    self.bookQuantity = ko.observable(data.bookQuantity);
    self.bookAvailable = ko.observable(data.bookAvailable);
};

function issued(data) {
    var self = this;
    self.bookTitle = ko.observable(data.bookTitle);
    //self.bookAuthor = ko.observable(data.bookAuthor);
    self.bookIssuedToUser = ko.observable(data.bookIssuedToUser);
    self.bookIssueDate = ko.observable(data.bookIssueDate);
    self.bookReturnDate = ko.observable(data.bookReturnDate);
};

//library view model
var libBook = function () {
    
    var self = this;  
    self.bookList = ko.observableArray();
    self.issueList = ko.observableArray();

    self.applyTemplate = function (vmInst, ele) {
        var jqEle = jQ(ele)[0];
        ko.cleanNode(jqEle);
        ko.applyBindings(vmInst, jqEle);
    };
    self.addBookToIssued = function (data) {
        var ln = data.length;
        for (i = 0; i < ln; i++) {
            console.log(data[i]);
            self.issueList.push(new issued(data[i]));
        }

    };
    self.addBookToList = function (data) {
        var ln = data.length;
        for (i = 0; i < ln; i++) {
            console.log(data[i]);
            self.bookList.push(new book(data[i]));
        }
    };

    function init() {
        //get from list he json object of bookissueedlist
        var issueData = [{
            bookTitle: "abc title1",
            bookIssuedToUser: "rahul dravid"
        }, {
            bookTitle: "abc title2",
            bookIssuedToUser: "rahul dravid"
        }, {
            bookTitle: "abc title3",
            bookIssuedToUser: "rahul dravid"
        }, {
            bookTitle: "abc title4",
            bookIssuedToUser: "rahul dravid"
        }];
        var bookListData = [{
            bookTitle: "happy Potter",
            bookAuthor: "j k Rowling",
            bookQuantity: 5
        }, {
            bookTitle: "happy Potter",
            bookAuthor: "j k Rowling",
            bookQuantity: 5
        }, {
            bookTitle: "happy Potter",
            bookAuthor: "j k Rowling",
            bookQuantity: 5
        }, {
            bookTitle: "happy Potter",
            bookAuthor: "j k Rowling",
            bookQuantity: 5
        }];
        self.addBookToIssued(issueData);
        self.addBookToList(bookListData);
    };
    self.printIssuedBooks = function () {
        logger.log("Displaying user issued books. get data from list");

        var rootWeb = appContext.get_web();
        var spListobj = rootWeb.get_lists().getByTitle("Book Lists");
        var spCamlQuery = new SP.CamlQuery();

        var spViewXML = '<View><Query><OrderBy><FieldRef Name="Title" Ascending="True"></FieldRef></OrderBy></Query></View>';
        spCamlQuery.set_viewXml(spViewXML);

        spListobjItems = spListobj.getItems(spCamlQuery);
        appContext.load(spListobjItems, "Include(Title)"); //, DateofIssue, IssuedTo, DateofReturn, RatingsofBook
        appContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

        function onQuerySuccess() {
            logger.log("Succeded");
            //console.log(this.spListobjItems.get_count());
            //debugger;
            var itemEnum = spListobjItems.getEnumerator();

            if (spListobjItems.get_count() > 0) {

                while (itemEnum.moveNext()) {
                    var currentItem = itemEnum.get_current();
                    var data = {
                        Title: currentItem.get_item("Title"),
                        //IssuedTo: currentItem.get_item("DateofIssue"),
                        //Title: currentItem.get_item("IssuedTo"),
                        //Title: currentItem.get_item("DateofReturn"),
                        //Title: currentItem.get_item("RatingsofBook")

                    };
                    self.AddBooksToUserIssued(data);
                    logger.log("Succeded in while");
                    return;
                }

            }

          
        };

        function onQueryFailed(sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        };






    };

    init();

};





var app = (function (jQuery, trace, userService, context, bookService) {

    function _init() {
        trace.log("Bootstrap!!!");

        userService.PrintCurrentUser();

        var vmInst = new libBook();
        //var viewModelInst = new bookIssuedVM();
        vmInst.applyTemplate(vmInst, "#booksElement");
        vmInst.applyTemplate(vmInst, "#issuedElement");

        vmInst.printIssuedBooks();




    };
    return {
        //load: _loadDependencies,
        init: _init
    };
})(jQ, logger, userModule, appContext, libBook);




jQ(document).ready(function(){
    app.init();
});

/*






function onQueryFailed(sender, args) {
    console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}

function onQuerySucceeded() {
    console.log('Item created: ' + oListItem.get_id());
}


function createListItem() {

    var oList = context.get_web().get_lists().getByTitle('Library Book Lists');
    var itemCreateInfo = new SP.ListItemCreationInformation();
    oListItem = oList.addItem(itemCreateInfo);
    oListItem.set_item('Title', '2 States');
    //oListItem.set_item('Author', 'Nitesh Patare');

    oListItem.update();

    context.load(oListItem);

    context.executeQueryAsync(Function.createDelegate(this, onQuerySucceeded), Function.createDelegate(this, onQueryFailed));
}

*/

