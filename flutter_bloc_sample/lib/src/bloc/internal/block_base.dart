
/// An abstrat base class for implmenting BLoC component. 
/// All BLoc components must dispose their streams when not required. Hence ! the dispose methods.
 
abstract class BaseBloc {
  void dispose();
}
