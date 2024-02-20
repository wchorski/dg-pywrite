---
{"dg-publish":true,"permalink":"/developer/ReactJS/React Click Off to Close Drawer/","noteIcon":""}
---

I'm integrating a shopping cart into my [[developer/ReactJS/ReactJS\|developer/ReactJS/ReactJS]] app. For modern user experience, I want the side cart to close if the user clicks off of the cart menu. 

The solution was to use React's [[[useCallback – React](https://react.dev/reference/react/useCallback\|useCallback Hook]]) with a global context boolean

```tsx
const [toggleNav, setToggleNav] = useState(false);
  const mobileMenuRef = useRef();

  const closeOpenMenus = useCallback(
    (e) => {
      if (
        mobileMenuRef.current &&
        toggleNav &&
        !mobileMenuRef.current.contains(e.target)
      ) {
        setToggleNav(false);
      }
    },
    [toggleNav]
  );

  useEffect(() => {
    document.addEventListener("mousedown", closeOpenMenus);
  }, [closeOpenMenus]);

	return (
		<nav
			ref={mobileMenuRef}
		> 							
			<button>
				close menu
			</button>
			...the_menu
		</nav>
	)
```


---
## Credits
- [Kamen Kanchev](https://stackoverflow.com/a/75477643/15579591)