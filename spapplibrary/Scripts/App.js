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
    _cururl += '/Lists/LibraryIssuedBookLists/NewForm.aspx?RootFolder=';
    SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Issue Book', allowMaximize: true, showClose: true });
    //window.location.reload();
    return false;
};

function addBook() {

    var currUrl = appContext.get_url();
    var _cururl = 'https://' + window.location.host + currUrl;
    _cururl += '/Lists/AllBooksList/NewForm.aspx?RootFolder=';
    SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Add Book', allowMaximize: true, showClose: true });
    return false;
};

//bookissuedto function/model


function book(data) {
    var self = this;
    self.bookTitle = ko.observable(data.bookTitle);
    self.bookAuthor = ko.observable(data.bookAuthor);
    self.bookQuantity = ko.observable(data.bookQuantity);
    self.bookAvailable = ko.observable(data.bookAvailable);
    self.bookRatings = ko.observable(data.bookRatings);
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
    self.isIssue = ko.observable(false);
    self.applyTemplate = function (vmInst, ele) {
        var jqEle = jQ(ele)[0];
        ko.cleanNode(jqEle);
        ko.applyBindings(vmInst, jqEle);
    };
    self.addBookToIssued = function (data) {
        var ln = data.length;
        for (i = 0; i < ln; i++) {
            console.log(data[i]);
            debugger;
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
            bookIssuedToUser: "rahul dravid",
            bookIssueDate: "2/4/2014",
            bookReturnDate: "12/4/2014"
        }, {
            bookTitle: "abc title2",
            bookIssuedToUser: "rahul dravid",
            bookIssueDate: "2/4/2014",
            bookReturnDate: "12/4/2014"
        }, {
            bookTitle: "abc title3",
            bookIssuedToUser: "rahul dravid",
            bookIssueDate: "2/4/2014",
            bookReturnDate: "12/4/2014"
        }, {
            bookTitle: "abc title4",
            bookIssuedToUser: "rahul dravid",
            bookIssueDate: "2/4/2014",
            bookReturnDate: "12/4/2014"
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
        var spListobj = rootWeb.get_lists().getByTitle("Issued Book Lists");
        var spCamlQuery = new SP.CamlQuery();

        var spViewXML = '<View><Query><OrderBy><FieldRef Name="Title" Ascending="True"></FieldRef></OrderBy></Query></View>';
        spCamlQuery.set_viewXml(spViewXML);
        spListobjItems = spListobj.getItems(spCamlQuery);

        appContext.load(spListobjItems, "Include(Title, DateofIssue, IssuedTo, DateofReturn)");
        appContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

        function onQuerySuccess() {
            logger.log("Succeded");
            //console.log(this.spListobjItems.get_count());
            //debugger;
            var itemEnum = spListobjItems.getEnumerator();

            if (spListobjItems.get_count() > 0) {
                var issueData;
                while (itemEnum.moveNext()) {
                    var currentItem = itemEnum.get_current();

                    function getSPDate(dt) {
                        var currentDate = new Date(dt);
                        return fullDate = currentDate.getDate() + "/" + (currentDate.getMonth() + 1) + "/" + currentDate.getFullYear();
                    };

                    issueData = [{
                        bookTitle: currentItem.get_item("Title"),
                        bookIssuedToUser: currentItem.get_item("DateofIssue")[0].$4A_1,
                        bookIssueDate: getSPDate(currentItem.get_item("IssuedTo")),
                        bookReturnDate: getSPDate(currentItem.get_item("DateofReturn"))
                    }];
                    logger.log("from server" + issueData);
                    //self.addBookToIssued(issueData);
                    /**/

                    ko.utils.arrayPushAll(self.issueList, GetIssued(issueData));

                    function GetIssued(result) {
                        var _result = ko.utils.arrayMap(result, function (item) {
                            return new issued(item);
                        });

                        return _result;
                    };
                    /**/
                }

                logger.log("Succeded in while");
            }
        };

        function onQueryFailed(sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        };

    };

    self.printAllBooks = function () {
        logger.log("Displaying all books. get data from list");

        var rootWeb = appContext.get_web();
        var spListobj = rootWeb.get_lists().getByTitle("All Books List");
        var spCamlQuery = new SP.CamlQuery();

        var spViewXML = '<View><Query><OrderBy><FieldRef Name="Title" Ascending="True"></FieldRef></OrderBy></Query></View>';
        spCamlQuery.set_viewXml(spViewXML);
        spListobjItems = spListobj.getItems(spCamlQuery);

        appContext.load(spListobjItems, "Include(Title, BookAuthor, NoofBooks, BookAvailable, BookRatings)");
        appContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

        function onQuerySuccess() {
            logger.log("Succeded");
            //console.log(this.spListobjItems.get_count());
            //debugger;
            var itemEnum = spListobjItems.getEnumerator();

            if (spListobjItems.get_count() > 0) {
                var issueData;
                while (itemEnum.moveNext()) {
                    var currentItem = itemEnum.get_current();

                    allData = [{
                        bookTitle: currentItem.get_item("Title"),
                        bookAuthor: currentItem.get_item("BookAuthor"),
                        bookQuantity: currentItem.get_item("NoofBooks"),
                        bookAvailable: currentItem.get_item("BookAvailable"),
                        bookRatings: currentItem.get_item("BookRatings")
                    }];
                    logger.log("From Server" + allData);
                    self.addBookToList(allData);
                }


                logger.log("Succeded in while");


            }


        };

        function onQueryFailed(sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        };

    };

    self.issueNewBook = function () {
        self.isIssue(true);
        logger.log("root");
    };

    self.tempbookTitle = ko.observable();
    self.tempbookIssuedToUser = ko.observable();
    self.tempbookIssueDate = ko.observable();
    self.tempbookReturnDate = ko.observable();
    self.issueNewBookSP = function () {
        console.log("S.P");
        var issueData = [{
            bookTitle: self.tempbookTitle(),
            bookIssuedToUser: self.tempbookIssuedToUser(),
            bookIssueDate: self.tempbookIssueDate(),
            bookReturnDate: self.tempbookReturnDate()
        }];
        logger.log("from cl to sp::" + issueData);
        self.addBookToIssued(issueData);

        /*server part*/

        createListItem(issueData);

        function onQueryFailed(sender, args) {
            logger.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        }

        function onQuerySucceeded() {
            logger.log('Item created: ' + oListItem.get_id());
        }


        function createListItem(issueData) {

            var oList = appContext.get_web().get_lists().getByTitle('Issued Book Lists');
            var itemCreateInfo = new SP.ListItemCreationInformation();
            oListItem = oList.addItem(itemCreateInfo);
            oListItem.set_item('Title', issueData[0].bookTitle);
            //oListItem.set_item('DateofIssue', issueData[0].bookIssueDate);
            //oListItem.set_item('IssuedTo', issueData[0].bookIssuedToUser);
            //oListItem.set_item('IssuedTo', "nitesh.patare@zevenseas.com");
            //oListItem.set_item('DateofReturn', issueData[0].bookReturnDate);
            try {
                oListItem.update();
            }
            catch (exception) {

            }

            appContext.load(oListItem);

            appContext.executeQueryAsync(Function.createDelegate(this, onQuerySucceeded), Function.createDelegate(this, onQueryFailed));
        }
    };
    init();

};





var app = (function (jQuery, trace, userService, context, bookService) {

    function _init() {
        trace.log("Bootstrap!!!");

        userService.PrintCurrentUser();

        var vmInst = new libBook();
        vmInst.printIssuedBooks();
        vmInst.applyTemplate(vmInst, "#dashboard-overview");
        //vmInst.applyTemplate(vmInst, "#issuedElement");



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

