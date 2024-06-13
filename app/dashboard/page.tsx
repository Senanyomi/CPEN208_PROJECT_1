'use client'
import React from 'react'
import styles from './dashboard.module.css'
import Image from 'next/image'
import Router, { useRouter } from 'next/navigation'

const dashboard = () => {
  const route = useRouter();
  return (
    <div className={styles.screen}>
      <section className={styles.menu}>
        <p className={styles.heading}>Computer Engineering Department</p>
        <button className={styles.menuBtn}>Profile</button>
        <button className={styles.menuBtn}>My Courses</button>
        <button className={styles.menuBtn}>Announcements</button>
      </section>
      <div className={styles.main}>
        <div className={styles.header}>
          <p className={styles.dash}>Dashboard</p>
          <div className={styles.options}>
            <input type="text" className={styles.mainInput} placeholder='search' />
          </div>
        </div>
        <div className={styles.body}>
          <div className={styles.information}>
          <div className={styles.infoText}>
            <h2 className={styles.h1}>Welcome Student!</h2>
            <p >You have 2 important announcements!</p>
            <p >You have 2 assignments!</p>
            <p >You have 2 upcoming deadlines!</p>
          </div>

          </div>
          <div className={styles.courses}>
            <div className={styles.courseCardDD}>
              <h2 className={styles.course}>Linear Circuits</h2>
            </div>

            <div className={styles.courseCardDSA}>
              <h2 className={styles.course}>Data Structures and Algorithms</h2>
            </div>

            <div className={styles.courseCardSE}>
              <h2 className={styles.course}>Software Engineering</h2>
            </div>

            <div className={styles.courseCardC}>
              <h2 className={styles.course}>Differential Equations</h2>
            </div>
           
          </div>
        </div>

      </div>
      
      <div className={styles.side}>
        <div className={styles.sideCards}>
          <div className={styles.fees}>
            {/* <Image src='/chart.png' width={50} height={50}/> */}
            <p>You owe the institutions: 100.00</p>
            {/* <button className={styles.feebtn} >Deposit <Image src='/right.png' width={20}height={20} /></button> */}
          </div>
        </div>
      </div>
      
      
      </div>
  )
}

export default dashboard