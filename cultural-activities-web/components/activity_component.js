import styles from "../styles/Home.module.css";
import { fetcher } from "../lib/utils";
import useSWR from "swr";
import {isEmpty, map} from 'lodash';
import { Card } from "antd";
import {useState} from "react";

const { Meta } = Card;

const Activity = ({searchParams, setSearchParams}) => {
  const [activities, setActivities] = useState([])
  const fetchActivities = isEmpty(activities) && isEmpty(searchParams) ? `${process.env.NEXT_PUBLIC_API_HOST}/activities` : null;
  useSWR(fetchActivities, fetcher, {
    onSuccess: (data) => {
      setActivities(data.cultural_activities);
      setSearchParams({});
    }
  });

  const searchPath = `${process.env.NEXT_PUBLIC_API_HOST}/activities/search`;
  const searchActivities = !isEmpty(searchParams) ? [searchPath, { params: searchParams }] : null;
  useSWR(searchActivities, fetcher, {
    onSuccess: (data) => {
      setActivities(data.cultural_activities);
    }
  });

  return (

    <div className={styles.grid}>
      {
        map(activities, ({title, id, detail_url, description, image_url}) => (
          <Card
            key={id}
            hoverable
            className={styles.card}
            cover={<img src={image_url}/>}
          >
            <Meta title={title} description={description} />
          </Card>
        ))
      }
    </div>
  )
};

export default Activity;
