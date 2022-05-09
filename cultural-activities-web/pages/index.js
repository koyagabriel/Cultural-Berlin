import Head from 'next/head'
import styles from '../styles/Home.module.css'
import Layout from "../components/layout_component";

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Cultural Berlin</title>
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Cultural Berlin
        </h1>

        <p className={styles.description}>
          View all your Cultural Activities in Berlin.
        </p>

        <Layout />

      </main>
    </div>
  )
}
