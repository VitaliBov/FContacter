import 'package:f_contacter/loader_search_bar/loader_search_bar.dart';
import 'package:f_contacter/presentation/bloc/contacts/contacts_bloc.dart';
import 'package:f_contacter/presentation/bloc/contacts/contacts_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/contacts/contacts_bloc_state.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_header_widget.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_item_widget.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_items.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_top_header_widget.dart';
import 'package:f_contacter/presentation/ui/widget/draggable_scrollbar.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/images.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key}) : super(key: key);

  @override
  State createState() => ContactsState();
}

class ContactsState extends State<ContactsScreen> with AutomaticKeepAliveClientMixin<ContactsScreen> {
  ContactsBloc _contactsBloc;
  ScrollController _scrollController;
  final _itemExtent = 100.0;

  @override
  void initState() {
    super.initState();
    _contactsBloc = ContactsBloc();
    _contactsBloc.dispatch(ContactsBlocEventLoad());
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _contactsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBlocEvent, ContactsBlocState>(
        bloc: _contactsBloc,
            builder: (context, state) {
              if (state is ContactsBlocStateSuccess) {
                return Scaffold(
                    appBar: _appBar(),
                    body: _listWidget(state.contacts)
                );
              }
              if (state is ContactsBlocStateError) {
                return _loadingWidget();
                //TODO add error
              }
              if (state is ContactsBlocStateLoading) {
                return _loadingWidget();
              }
            }
    );
  }

  Widget _appBar() => SearchBar(
      defaultBar: AppBar(
          title: const Text(AppStrings.contactsScreenName),
          elevation: 0.0
      ),
      searchItem: SearchItem.action(
          builder: (_) => IconButton(
            icon: SvgPicture.asset(AppImages.icSearch),
            onPressed: () {},
          )
      ),
      searchHint: AppStrings.contactsActionSearch,
      attrs: SearchBarAttrs(
          secondaryDetailColor: AppColors.colorAccent
      ),
      onQueryChanged: (query) => _onQueryChanged(context, query),
      controller: SearchBarController(
          onActivatedChanged: (isActivate) => _onActivatedChanged(isActivate)
      )
  );

  Widget _listWidget(List<ContactsListItem> contacts) {
    return DraggableScrollbar.rrect(
      controller: _scrollController,
      labelTextBuilder: (offset) => _scrollbarTitle(contacts, offset),
      child: ListView.builder(
          controller: _scrollController,
          itemCount: contacts.length,
          itemExtent: _itemExtent,
          itemBuilder: (context, index) {
            var item = contacts[index];
            if (item is ContactsTopHeader) return ContactsTopHeaderWidget(data: item);
            if (item is ContactsHeader) return ContactsHeaderWidget(data: item);
            if (item is ContactsItem) return ContactsItemWidget(data: item);
          }
      )
    );
  }

  //TODO add loading widget
  Widget _loadingWidget() => Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator()
      )
  );

  Widget _scrollbarTitle(List<ContactsListItem> contacts, double offset) {
    String title = contacts[offset ~/ _itemExtent].title[0];
    return Text(
        title,
        style: TextStyle(color: AppColors.colorAccent)
    );
  }

  _onQueryChanged(BuildContext context, String query) {
    _contactsBloc.dispatch(ContactsBlocEventFilter(query));
  }

  _onActivatedChanged(bool isActivate) {
    _contactsBloc.dispatch(ContactsBlocEventFilter(""));
  }

  @override
  bool get wantKeepAlive => true;
}