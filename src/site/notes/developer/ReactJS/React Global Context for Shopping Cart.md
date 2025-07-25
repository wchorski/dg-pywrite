---
{"dg-publish":true,"tags":["reactjs","NextJS"],"permalink":"/developer/react-js/react-global-context-for-shopping-cart/","dgPassFrontmatter":true}
---


here is a quick example of using [[developer/ReactJS/ReactJS\|ReactJS]] global context for 
- opening / closing cart drawer
- cart item contents for the user 

```tsx
'use client'
import { CartItem, User } from "@ks/types";
import { client } from "@lib/request";
import { gql } from "graphql-request";
import { ReactNode, createContext, useContext, useState } from "react";

const defaultCtx= {
  isOpen: false,
  setIsOpen: (isOpen:boolean) => {},
  toggleCart: () => {},
  closeCart: () => {},
  openCart: () => {},

  cartItems: [],
  setCartItems: (cartItems:CartItem[]) => [],
  addToCart: (cartItem:CartItem) => {},
  removeFromCart: (id:string) => {},
  getUserCart: (sessionId:string) => {},
}

const LocalStateContext = createContext(defaultCtx)

function CartStateProvider ({children}:{children: ReactNode}){

  const [isOpen, setIsOpen] = useState<boolean>(false)
  const [cartItems, setCartItems] = useState<CartItem[]>([])

  // function addToCart(cartItem:CartItem){
  //   console.log('add to cart');
    
  //   console.log({cartItem});
  //   setCartItems(prev => [...prev, cartItem])
  // }

  async function getUserCart(sessionId:string){
    const variables = {
      where: {
        id: sessionId
      }
    }

    try {
      const { user } = await client.request(query, variables) as { user:User }
      // console.log(user.cart);

      if(!user.cart) return console.log('cart not found');
      
      // setCart(user.cart)
      setCartItems(user.cart)
      
      
    } catch (error) {
      console.log('!!! getusercart: ', error);
      
    }
  }

  function removeFromCart(id:string){
    console.log('remove from cart');
    console.log({id});
    const updatedItems = cartItems.filter(item => item.id !== id);
    setCartItems(updatedItems)
  }

  function toggleCart() {
    setIsOpen(!isOpen)
  }
  function closeCart() {
    setIsOpen(false)
  }
  function openCart() {
    setIsOpen(true)
  }

  return(
    <LocalStateContext.Provider 
      value={{
        isOpen, 
        setIsOpen, 
        toggleCart, 
        closeCart, 
        openCart,
        cartItems,
        setCartItems,
        getUserCart,
        removeFromCart,
      }}
    >
      {children}
    </LocalStateContext.Provider>
  )
} 

function useCart(){
  const all = useContext(LocalStateContext)
  return all
}
export {CartStateProvider, useCart}

const query = gql`
  query getUserCart($where: UserWhereUniqueInput!) {
    user(where: $where) {
      cart {
        id
        quantity
        product {
          id
          price
          name
          image
        }
      }
    }
  }
`
```