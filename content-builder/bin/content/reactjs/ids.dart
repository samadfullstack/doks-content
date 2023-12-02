enum Hooks {
  hooks,
  use,
  useCallback,
  useContext,
  useDebugValue,
  useDeferredValue,
  useEffect,
  useId,
  useImperativeHandle,
  useInsertionEffect,
  useLayoutEffect,
  useMemo,
  useOptimistic,
  useReducer,
  useRef,
  useState,
  useSyncExternalStore,
  useTransition,
  ;

  final String prefix_ = "reactJs";

  String get prefix => "$prefix_:$name";
  String unfix() => name.replaceAll(prefix_, "");
}

enum Components {
  component,
  components,
  fragment,
  profiler,
  strictMode,
  suspense,
  ;

  final String prefix_ = "reactJs";

  String get prefix => "$prefix_:$name";
  String unfix() => name.replaceAll(prefix_, "");
}

enum Apis {
  apis,
  cache,
  createContext,
  forwardRef,
  lazy,
  memo,
  startTransition,
  experimentalTaintObjectReference,
  experimentalTaintUniqueValue,
  experimentalUseEffectEvent,
  ;

  final String prefix_ = "reactJs";

  String get prefix => "$prefix_:$name";
  String unfix() => name.replaceAll(prefix_, "");
}

enum Directives {
  directives,
  useClient,
  useServer,
  ;

  final String prefix_ = "reactJs";

  String get prefix => "$prefix_:$name";
  String unfix() => name.replaceAll(prefix_, "");
}
