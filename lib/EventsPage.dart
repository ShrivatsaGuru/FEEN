import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3A7CE0)),
          onPressed: () {
            // If EventsPage is not the first page, Navigator.pop(context) is fine.
            // If it's the root, you might want to handle this differently (e.g., exit app or do nothing).
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Events',
          style: TextStyle(
            color: Color(0xFF3A7CE0),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDateSelector(),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildEventCard("Event 1"),
                  _buildEventCard("Event 2"),
                  // Add more event cards here if needed
                  // _buildEventCard("Event 3"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF3A7CE0),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.campaign_outlined),
              activeIcon: Icon(Icons.campaign),
              label: 'Alerts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.headset_mic_outlined),
              activeIcon: Icon(Icons.headset_mic),
              label: 'Support'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation tap here
          print("Tapped on item $index");
          // Example: You might use a PageController or Navigator to switch views
        },
      ),
    );
  }

  // Date Selector Widget (using the HorizontallyScrollableDateSelector)
  Widget _buildDateSelector() {
    return HorizontallyScrollableDateSelector(
      onDateSelected: (date) {
        print("Selected date from EventsPage: $date");
        // You can update the state of EventsPage or trigger data fetching for the selected date
      },
      accentColor: Color(0xFF3A7CE0), // Consistent accent color
      borderColor: Color(0xFF3A7CE0).withOpacity(0.5), // Slightly softer border
    );
  }

  // Event Card Widget
  Widget _buildEventCard(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF3A7CE0).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                  color: Color(0xFF3A7CE0),
                  borderRadius: BorderRadius.circular(3)
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text("Location", style: TextStyle(color: Colors.black54, fontSize: 13)),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text("Duration", style: TextStyle(color: Colors.black54, fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Details about the event about to happen.",
                    style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Horizontally Scrollable Date Selector Widget
class HorizontallyScrollableDateSelector extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final Color? accentColor;
  final Color? borderColor;

  const HorizontallyScrollableDateSelector({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.accentColor,
    this.borderColor,
  });

  @override
  _HorizontallyScrollableDateSelectorState createState() =>
      _HorizontallyScrollableDateSelectorState();
}

class _HorizontallyScrollableDateSelectorState
    extends State<HorizontallyScrollableDateSelector> {
  late DateTime _selectedDate;
  late DateTime _focusedMonth;
  late PageController _pageController;
  late DateTime _baseDateForPageController;

  final int _initialPageOffset = 1200; // 100 years * 12 months
  final int _totalMonths = 2400; // 200 years * 12 months

  late Color _accentColor;
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    _baseDateForPageController = DateTime(
        _focusedMonth.year, _focusedMonth.month - _initialPageOffset, 1);
    _pageController = PageController(initialPage: _initialPageOffset);

    _accentColor = widget.accentColor ?? Color(0xFF3A7CE0);
    _borderColor = widget.borderColor ?? Color(0xFF3A7CE0);
  }

  @override
  void didUpdateWidget(HorizontallyScrollableDateSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsPageUpdate = false;

    if (widget.initialDate != null && widget.initialDate != _selectedDate) {
      _selectedDate = widget.initialDate!;
      DateTime newFocusedMonthCandidate = DateTime(_selectedDate.year, _selectedDate.month, 1);
      if (newFocusedMonthCandidate != _focusedMonth) {
        _focusedMonth = newFocusedMonthCandidate;
        needsPageUpdate = true;
      }
    }

    if (widget.accentColor != null && widget.accentColor != _accentColor) {
      _accentColor = widget.accentColor!;
    }
    if (widget.borderColor != null && widget.borderColor != _borderColor) {
      _borderColor = widget.borderColor!;
    }

    if (needsPageUpdate) {
      int yearDiff = _focusedMonth.year - _baseDateForPageController.year;
      int monthDiffInYears = yearDiff * 12;
      int targetPage = monthDiffInYears + (_focusedMonth.month - _baseDateForPageController.month);

      if (_pageController.hasClients && targetPage >= 0 && targetPage < _totalMonths) {
        if ((_pageController.page?.round() ?? _initialPageOffset) != targetPage) {
          _pageController.jumpToPage(targetPage);
        }
      } else if (targetPage >= 0 && targetPage < _totalMonths) {
        _pageController.dispose();
        _pageController = PageController(initialPage: targetPage);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getMonthYearString(DateTime date) {
    // This requires the intl package to be correctly imported and resolved.
    return DateFormat.yMMMM().format(date);
  }

  List<DateTime?> _getCalendarDaysForMonth(DateTime monthToDisplay) {
    final firstDayOfMonth = DateTime(monthToDisplay.year, monthToDisplay.month, 1);
    final daysInMonth = DateTime(monthToDisplay.year, monthToDisplay.month + 1, 0).day;
    List<DateTime?> calendarDays = [];
    // Adjust for Dart's DateTime.weekday (Monday=1, Sunday=7)
    int leadingEmptyCellCount = (firstDayOfMonth.weekday - DateTime.monday + 7) % 7;
    for (int i = 0; i < leadingEmptyCellCount; i++) {
      calendarDays.add(null);
    }
    for (int i = 0; i < daysInMonth; i++) {
      calendarDays.add(DateTime(monthToDisplay.year, monthToDisplay.month, i + 1));
    }
    while (calendarDays.length < 42) { // Ensure 6 weeks (42 cells) for consistent height
      calendarDays.add(null);
    }
    return calendarDays;
  }

  void _onArrowPressed(int direction) {
    if (direction < 0 && _pageController.page! > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else if (direction > 0 && _pageController.page! < _totalMonths - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Widget _buildMonthPage(DateTime monthToDisplay) {
    final calendarDays = _getCalendarDaysForMonth(monthToDisplay);
    final List<String> dayAbbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayAbbreviations
              .map((dayAbbr) => Expanded(
            child: Center(
              child: Text(
                dayAbbr,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
          ))
              .toList(),
        ),
        SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: calendarDays.length,
            itemBuilder: (context, index) {
              final date = calendarDays[index];
              if (date == null) return Container();

              // *** TYPO FIX HERE ***
              final bool isSelected = date.year == _selectedDate.year &&
                  date.month == _selectedDate.month &&
                  date.day == _selectedDate.day; // Was _selectedDdate.day
              final DateTime now = DateTime.now();
              final bool isToday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;
              final bool isOutsideFocusedMonth = date.month != monthToDisplay.month;

              return GestureDetector(
                onTap: () {
                  if (isOutsideFocusedMonth) return;
                  setState(() => _selectedDate = date);
                  if (widget.onDateSelected != null) {
                    widget.onDateSelected!(date);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _accentColor
                        : isToday && !isOutsideFocusedMonth
                        ? _accentColor.withOpacity(0.25)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected && !isOutsideFocusedMonth
                        ? Border.all(color: _accentColor.withOpacity(0.8), width: 1)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isOutsideFocusedMonth
                          ? Colors.grey.shade400
                          : isToday ? _accentColor : Colors.black87,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.fromLTRB(4, 12, 4, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: _accentColor, size: 18),
                onPressed: () => _onArrowPressed(-1),
                splashRadius: 20,
              ),
              Text(
                _getMonthYearString(_focusedMonth),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _accentColor,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: _accentColor, size: 18),
                onPressed: () => _onArrowPressed(1),
                splashRadius: 20,
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalMonths,
              onPageChanged: (page) {
                setState(() {
                  _focusedMonth = DateTime(_baseDateForPageController.year,
                      _baseDateForPageController.month + page, 1);
                });
              },
              itemBuilder: (context, pageIndex) {
                DateTime monthToDisplay = DateTime(_baseDateForPageController.year,
                    _baseDateForPageController.month + pageIndex, 1);
                return _buildMonthPage(monthToDisplay);
              },
            ),
          ),
        ],
      ),
    );
  }
}
