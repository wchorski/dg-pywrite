---
{"dg-publish":true,"permalink":"/developer/NextJS/NextJS Data Fetch with GraphQL/","dgPassFrontmatter":true}
---

```tsx
import React, { Fragment } from 'react';
import type { GetStaticPathsResult, GetStaticPropsContext } from 'next';
import Link from 'next/link';
import type { DocumentRendererProps } from '@keystone-6/document-renderer';
import { InferRenderersForComponentBlocks } from '@keystone-6/fields-document/component-blocks';
import { DocumentRenderer } from '@keystone-6/document-renderer';
import { fetchGraphQL, gql } from '../../graphql';
import { BlockRenderer } from '../../components/blocks/BlocksRenderer';

export type DocumentProp = DocumentRendererProps['document'];

type Post = {
  id: string;
  title: string;
  slug: string;
  publishDate: string | null;
  author: {
    name: string;
  } | null;
  content: {
    document: DocumentProp;
  };
};

export default function BlogPage({ post, error }: { post: Post | undefined; error?: Error }) {
  if (error) {
    return (
      <>
        <h1>Something went wrong</h1>
        <pre>{error.message}</pre>
      </>
    );
  }

  if (!post) {
    return <div>Post not found</div>;
  }

  return (
    <>
      <div>
        <Link href="/">&larr; back home</Link>
      </div>

      <article>

        <h1>{post.title}</h1>

        <p>
          {post.publishDate ? (
            <span>
              <em>Published on {new Date(post.publishDate).toLocaleDateString()}</em>
            </span>
          ) : null}
          {post.author?.name ? (
            <span>
              <em> · by {post.author?.name}</em>
            </span>
          ) : null}
        </p>

        <BlockRenderer document={post.content.document} />
        {/* <DocumentRenderer document={post.content.document} /> */}

      </article>

    </>
  )
}

export async function getStaticPaths(): Promise<GetStaticPathsResult> {
  try {
    const data = await fetchGraphQL(gql`
      query posts {
        posts {
          slug
        }
      }
    `);


    const posts: { slug: string }[] = data?.posts || [];
    const paths = posts.map(({ slug }) => ({
      params: { slug },
    }));

    return {
      paths,
      fallback: false,
    };
  } catch (e) {
    return {
      paths: [],
      fallback: false,
    };
  }
}

export async function getStaticProps({ params = {} }: GetStaticPropsContext) {
  const slug = params.slug;

  try {
    const data = await fetchGraphQL(
      gql`
        query post($slug: String!) {
          post(where: { slug: $slug }) {
            id
            title
            slug
            featured_image
            featured_video
            status
            template
            dateCreated
            dateModified
            categories {
              name
              id
            }
            tags {
              name
              id
            }
            author {
              name
            }
            content {
              document
            }
          }
        }
      `,
      {
        slug,
      }
    );

    const post = data?.post;

    return { props: { post } };
  } catch (e) {
    console.log('>-------- ERRROR');
    return {
      props: {
        post: { id: '123', title: 'thie title' },
        error: { name: (e as Error).name, message: (e as Error).message },
      },
    };
  }
}
```